class iodine::server(
  $domain,
  $server_ip,
  $password = trocla("iodine_${::fqdn}",'plain'),
  $manage_shorewall = false,
  $shorewall_masq = true,
  $shorewall_zone = 'net',
  $shorewall_interface = 'eth0'
) {
  case $::operatingsystem {
    'debian','ubuntu': { include iodine::server::debian }
    default: { include iodine::server::base }
  }

  if $manage_shorewall {
    include shorewall::rules::dns
    if $shorewall_masq {
      class{'iodine::server::shorewall_masq':
        zone => $shorewall_zone,
        interface => $shorewall_interface
      }
    }
  }
}
