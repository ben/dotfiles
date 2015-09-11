# Anybar alias

function anybar { echo -n $1 | nc -4u -w0 localhost ${2:-1738}; }

# TODO: check boot2docker status every 10 seconds?
