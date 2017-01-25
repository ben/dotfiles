

function sup() {
	zdi vm start
	sleep 5
	zdi services restart
	zdi apps restart
	echo aight yo
}
