# function staging () {
#   sudo sh -c 'for IP in $(dig +short zendesk-staging.com); do route add ${IP} -netmask 255.192.0.0 -iface gpd0; done'
# }
