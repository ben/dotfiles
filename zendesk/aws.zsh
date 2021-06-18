#!/bin/bash
#
# Authenticates you via Okta with a selected aws account and stores the credential in ~/.aws/credentials
#
# `aws-login zendesk`
#
# Source this file from your .bashrc or execute it
#
# Keep it bash/zsh portable:
#  - use [[ instead of [ and posix = instead of bash ==
#  - avoid special bash env vars.
#  - TODO: add instructions how to quickly test via zsh and bash
function aws-login {
    NAME="aws-login"
    [[ "$AWS_LOGIN_SOURCED" = "1" ]] && NAME="$(basename "${0}")"

    # cache available accounts
    accounts=~/.saml2aws-accounts
    if [[ ! -f $accounts ]]; then
        >&2 echo "Caching accounts into $accounts, check your Duo"
        # stderr added to the cached account file as a workaround to the saml2aws issue https://github.com/Versent/saml2aws/issues/559
        (echo "Duo" | saml2aws list-roles --skip-prompt &> $accounts) || {
          echo "Failed: make sure to be on RFA when using global-protect, response was:"
          cat $accounts
          rm $accounts
          false
          return
        }
    fi

    # tell user how to use this or list accounts
    if [[ -z "$1" ]] || [[ "$1" = "--list-accounts" ]]; then
        if [[ -z "$1" ]]; then
          echo "USAGE: ${NAME} [account]"
          echo Where account is one of:
        fi
        grep '^Account:' $accounts     \
          | awk '{print $2" "$2" "$3}' \
          | sed 's/zendesk-//'         \
          | column -s ' ' -t
        [[ ! -z "$1" ]] # true/false depending if this was for usage
        return
    fi

    function get-section {
      echo "$(awk "/^Account:[[:blank:]]{1}($1[[:blank:]]{1}|zendesk-$1[[:blank:]]{1}|[[:alnum:]]+[[:blank:]]{1}\($1\))/" RS= $accounts)"
    }

    function get-profile {
      echo "$(echo $section | head -1 | sed 's/Account: //' | sed 's/ .*//' | sed 's/^zendesk-//' )"
    }

    function login {
      # ask user to select arn when multiple have the same name but different role
      PS3='Select a role:'
      if [[ $(echo -n "$arns" | grep -c '^') -gt 1 && "$PROMPT" != "NO" ]]; then
        select arn in $arns;
        do
          if [[ -n $arn ]]; then
            echo "Using $arn"
            break
          else
            echo "Select an option"
          fi
        done
      else
        arn=$(echo "$section" | head -2 | tail -1)
      fi

      if [[ -z "$arn" ]]; then
        echo "No matching account found for $profile, use --list-accounts to see available accounts or 'all' to login to all accounts"
        false
        return
      fi

      # max session duration is enforced via okta at 4 hours -> 14400 seconds
      echo "Logging in to $profile via role $arn"
      echo 'Duo' | saml2aws login --skip-prompt --profile $profile --role $arn --session-duration 14400
      if [[ "$?" != "0" ]]; then
        echo "Failed: make sure to be on RFA when using global-protect."
        false
        return
      fi
    }

    if [[ "$1" = "all" ]]; then
      profiles=($(cat $accounts | grep Account: | sed 's/.* \(.*\) .*/\1/'))
    elif [[ "$1" = "compute" ]]; then
      profiles=(staging zendesk production virginia frankfurt)
    else
      profiles=($@)
    fi

    if [[ "$2" = "--profile" ]]; then
      section=$(get-section $1)
      echo $(get-profile $section)
      return
    fi

    for profile in "${profiles[@]}"
    do
      section=$(get-section $profile)
      if [ -n "$ZSH_VERSION" ]; then
        IFS=$'\n' arns=($(echo "$section" | grep "arn:aws:iam"))
      else
        arns=$(echo "$section" | grep "arn:aws:iam")
      fi
      profile=$(get-profile $section)
      login $profile $arns "$section"
    done
}

# Bash auto-complete script for available profiles
function _saml2aws_profiles {
  local cachefile=~/.saml2aws-accounts
  if [[ ! -f ${cachefile} ]] ; then return 1 ; fi

  local profiles cur

  profiles=$(cat ${cachefile} | awk '$1 == "Account:" { print $2 }')
  cur="${COMP_WORDS[COMP_CWORD]}"

  COMPREPLY=( $(compgen -W "${profiles}" -- ${cur}) )
  return 0
}

complete -F _saml2aws_profiles aws-login

# allow sourcing or executing it
DIR=${BASH_SOURCE[0]-${(%):-%n}}
if [[ "$DIR" = "${0}" ]]; then
  AWS_LOGIN_SOURCED=1 aws-login $*
fi
