# redhat specific things
class iodine::server::redhat inherits iodine::server::base {
  Service['iodined']{
    name => 'iodine-server',
  }
  file{'/etc/sysconfig/iodine-server':
    content => template('iodine/sysconfig.erb'),
    require => Package['iodine'],
    notify  => Service['iodined'],
    owner   => root,
    group   => 0,
    mode    => '0600';
  }
}
