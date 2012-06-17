class iodine::server::shorewall_masq(
  $zone = 'net',
  $interface = 'eth0'
) {
  shorewall::interface { 'dns0':
    zone    =>  $zone,
    rfc1918 => true,
    options =>  'routeback,logmartians';
  }

  $nibbles = split($iodine::server::server_ip, '[.]')
  shorewall::masq{'dnsvpn':
    interface => $interface,
    source => "${nibbles[0]}.${nibbles[1]}.${nibbles[2]}.0/24"
  }

}
