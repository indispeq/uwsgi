#requires a defined uwsgi-app for this to work
class graphite::install inherits graphite {

  package { 'graphite-web':
    ensure => installed,
  }

  package { 'python-psycopg2':
    ensure => installed,
  }

  file { '/etc/graphite/local_settings.py':
    ensure  => present,
    content => template('graphite/local_settings.py.erb'),
    require => Package['graphite-web'],
  }

  exec { 'graphite-manage-syncdb-perms':
    command     => '/usr/bin/graphite-manage syncdb --noinput && /bin/chown -R _graphite:www-data /var/lib/graphite && /bin/chmod -R 770 /var/lib/graphite',
    require     => [ Package['graphite-web'], File['/etc/graphite/local_settings.py'], Postgresql::Server::Db[$db_name] ],
    notify      => Exec['refresh-app'],
  }


}
