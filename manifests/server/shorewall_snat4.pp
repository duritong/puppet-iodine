# setup shorewall masquerade
class iodine::server::shorewall_snat4(
  $zone = 'net',
  $interface = $facts['networking']['primary']
) {
  shorewall::interface { 'dns0':
    zone    =>  $zone,
    rfc1918 => true,
    options =>  'routeback,logmartians';
  }

  $nibbles = split($iodine::server::server_ip, '[.]')
  shorewall::snat4 { 'dnsvpn':
    action => "SNAT(${facts['networking']['interfaces'][$interface]['ip']})",
    dest   => $interface,
    source => "${nibbles[0]}.${nibbles[1]}.${nibbles[2]}.0/24";
  }

}
