function rollbar () {
  sudo sh -c 'for IP in $(dig +short rollbar-us.zendesk.com | grep -E "^(52|54)"); do route add ${IP} -netmask 255.192.0.0 -iface gpd0; done'
}
