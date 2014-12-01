class graphite::carbon inherits graphite {

  package { 'graphite-carbon':
    ensure => installed,
  }->

  augeas { 'graphite-carbon-default':
    context => "/files/etc/default/graphite-carbon",
    changes => [
      "set CARBON_CACHE_ENABLED true",
    ],
  }->

  file { '/etc/carbon/carbon.conf':
    ensure  => present,
    content => template('graphite/carbon.conf.erb'),
    require => Package['graphite-carbon'],
    notify  => Service['carbon-cache'],
  }->

  file { '/etc/carbon/storage-schemas.conf':
    ensure => present,
    content => template('graphite/storage-schemas.conf.erb'),
    require => Package['graphite-carbon'],
    notify  => Service['carbon-cache'],
  }->

  file { '/etc/carbon/storage-aggregation.conf':
    ensure  => present,
    content => template('graphite/storage-aggregation.conf.erb'),
    require => Package['graphite-carbon'],
    notify  => Service['carbon-cache'],
  }->

  service { 'carbon-cache':
    ensure => running,
    enable => true,
  }

  
}

