#
class statsd::install inherits statsd {
  $required_packages=['git', 'nodejs', 'devscripts', 'debhelper']

  package { $required_packages :
    ensure => installed,
  }->

  file { '/root/build' :
    ensure => directory,
  }->

  exec { 'clone-statsd-repo' :
    cwd     => '/root/build',
    command => '/usr/bin/git clone https://github.com/etsy/statsd.git',
    creates => '/root/build/statsd',
  }->

  exec { 'build-statsd-package' :
    cwd     => '/root/build/statsd',
    command => '/usr/bin/dpkg-buildpackage',
    creates => '/root/build/statsd_0.6.0-1_all.deb',
  }->
  
  package { 'statsd':
    ensure   => latest,
    provider => dpkg,
    source   => '/root/build/statsd_0.6.0-1_all.deb',
  }

  file { '/etc/statsd/localConfig.js':
    ensure  => present,
    content => template('statsd/localConfig.js.erb'),
    require => Package['statsd'],
    notify  => Service['statsd'],
  }

  service { 'statsd':
    ensure  => running,
    enable  => true,
    require => File['/etc/statsd/localConfig.js'],
  }

}

