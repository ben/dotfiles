alias dc=docker-compose
alias dm=docker-machine

function cdm () {
	eval $(docker-machine env $1);
}

