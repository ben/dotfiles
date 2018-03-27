function sup() {
	zdi services restart
	zdi apps restart
	zdi dnsmasq restart
	zdi inbox restart -d
}

alias zdi-update="pushd ~/Code/zendesk/docker-images; git pull --autostash --rebase; docker ps --format '{{.Names}}' | xargs -P 5 -I IMAGE sh -c 'zdi IMAGE pull -v && zdi IMAGE restart'; popd"

export DOCKER_NETWORK_PARAVIRTUALIZED=true
export DEDICATED_DOCKER_DISK=true
[[ -e ~/Code/zenesk/docker-images/dockmaster/zdi.sh ]] && source ~/Code/zendesk/docker-images/dockmaster/zdi.sh

export DOCKER_SHARE_IVY=true
export DOCKER_VM_MEMORY=7168
export DOCKER_VM_CPUS=2
