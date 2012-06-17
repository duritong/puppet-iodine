class iodine::server(
  $domain,
  $server_ip,
  $password,
  $manage_shorewall = false,
  $shorewall_masq   = true
) {
  case $::operatingsystem {
    'debian','ubuntu': { include iodine::server::debian }
    default: { include iodine::server::base }
  }

  if $manage_shorewall {
    include shorewall::rules::dns
    if $shorewall_masq {
      include iodine::server::shorewall_masq
    }
  }
}
