class uwsgi::install inherits uwsgi {

  $uwsgi_internal_directories = [ "$uwsgi_dir/etc","$uwsgi_dir/apps-available","$uwsgi_dir/apps-enabled"]

  user { 'uwsgi':
    ensure     => present,
    groups     => 'staff',
    managehome => true,
    system     => true,
  }

  python::virtualenv { $uwsgi_dir :
    ensure  => present,
    version => 'system',
    owner   => 'uwsgi',
    group   => 'staff',
    require => Class['python'],
  }->

  python::pip { 'uwsgi' :
    ensure     => present,
    virtualenv => $uwsgi_dir,
    url        => 'http://projects.unbit.it/downloads/uwsgi-lts.tar.gz',
  }->

  file { $uwsgi_internal_directories :
    ensure => directory,
    owner  => 'uwsgi',
    group  => 'staff',
  }->

  file { "$uwsgi_dir/etc/vassals-default.ini":
    ensure  => present,
    owner   => 'uwsgi',
    group   => 'staff',
    source  => 'puppet:///modules/uwsgi/vassals-default.ini',
  }->

  package { 'nginx':
    ensure => installed,
  }->

  file { '/etc/nginx/sites-enabled/default':
    ensure => absent,
  }->

  file { '/etc/nginx/uwsgi_params':
    ensure => present,
    group  => root,
    owner  => root,
    source => 'puppet:///modules/uwsgi/uwsgi_params',
  }

}
