source /Users/bstraub/Code/zendesk/docker-images/dockmaster/zdi.sh

export MYSQL_URL='mysql://admin:123456@apps.zd-dev.com:3306/zendesk_development'
export RAILS_MEMCACHED_HOSTS=zd-dev.com:11211
export REDIS_PORT=redis://zd-dev.com:6379/ # can go soon
export REDIS_URL=redis://zd-dev.com:6379/

function sup() {
	pushd ~/Code/zendesk/docker-images
	vagrant up
	zdi services restart
	zdi apps restart
	popd
	echo aight yo
}
