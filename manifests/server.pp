# an iodine server
class iodine::server(
  $domain,
  $server_ip,
  $listen_ip           = '0.0.0.0',
  $password            = trocla("iodine_${facts['fqdn']}",'plain'),
  $manage_shorewall    = false,
  $shorewall_masq      = true,
  $shorewall_zone      = 'net',
  $shorewall_interface = $facts['networking']['primary'],
) {
  case $osfamily {
    'Debian','Ubuntu': { include iodine::server::debian }
    'RedHat': { include iodine::server::redhat }
    default: { include iodine::server::base }
  }

  if $manage_shorewall {
    include shorewall::rules::dns
    if $shorewall_masq {
      class{'iodine::server::shorewall_masq':
        zone      => $shorewall_zone,
        interface => $shorewall_interface,
      }
    }
  }
}
