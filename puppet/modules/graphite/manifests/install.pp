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

}
