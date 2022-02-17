if hash rbenv 2>/dev/null; then
  eval "$(rbenv init -)"
fi

export CFLAGS="$CFLAGS -DHAVE_UNISTD_H"
