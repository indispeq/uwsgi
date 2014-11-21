class uwsgi::config inherits uwsgi {

  file { '/etc/init/uwsgi.conf' :
    ensure  => present,
    content => template('uwsgi/uwsgi.conf.erb'),
    notify  => Service['uwsgi'],
  }

}
