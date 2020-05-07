export DOCKER_FOR_MAC_ENABLED=true
export DOCKER_HOST_IP=172.17.0.1
export DOCKER_NETWORK_PARAVIRTUALIZED=true
export DEDICATED_DOCKER_DISK=true
[[ -r $HOME/Code/zendesk/zdi/dockmaster/zdi.sh ]] && source $HOME/Code/zendesk/zdi/dockmaster/zdi.sh

export DOCKER_SHARE_IVY=true
export DOCKER_VM_MEMORY=7168
export DOCKER_VM_CPUS=2

export KRAGLE_OAUTH_KEY=abc1234
export KRAGLE_OAUTH_SECRET=collaboration123

export REDIS_URL='redis://zd-dev.com:6379'

export ZENDESK_ELASTICSEARCH_URL='zd-dev.com:9200'
