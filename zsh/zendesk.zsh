source /Users/bstraub/Code/zendesk/docker-images/dockmaster/zdi.sh

alias zdinbox="zdi vm start; zdi services restart; zdi apps restart; cd ~/Code/zendesk/zendesk_inbox/; zdi inbox -d restart"
