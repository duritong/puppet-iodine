# an iodine server
class iodine::server (
  $domain,
  $server_ip,
  $listen_ip           = '0.0.0.0',
  $password            = trocla("iodine_${facts['networking']['fqdn']}",'plain'),
  $manage_shorewall    = false,
  $shorewall_snat4     = true,
  $shorewall_zone      = 'net',
  $shorewall_interface = $facts['networking']['primary'],
) {
  case $facts['os']['family'] {
    'Debian','Ubuntu': { include iodine::server::debian }
    'RedHat': { include iodine::server::redhat }
    default: { include iodine::server::base }
  }

  if $manage_shorewall {
    include shorewall::rules::dns
    if $shorewall_snat4 {
      class { 'iodine::server::shorewall_snat4':
        zone      => $shorewall_zone,
        interface => $shorewall_interface,
      }
    }
  }
}
