# need to create app_path and also add right perms for probably www-data
define uwsgi::graphiteapp (
  $app_url,
  $app_path,
  $app_module,
  $app_venv,
  $uwsgi_dir = hiera('uwsgi::uwsgi_dir'),
) {

  python::virtualenv { $app_venv :
    ensure  => present,
    version => 'system',
    owner   => 'uwsgi',                                                                                            group   => 'staff',                                                                                            require => Class['uwsgi'],
  }                              

  file { "${uwsgi_dir}/apps-available/${app_url}.ini":
    ensure  => present,
    content => template('uwsgi/uwsgi-graphite-vassal.ini.erb'),
    require => Package['graphite-web'],
  }->

  file { "${uwsgi_dir}/apps-enabled/${app_url}.ini":
    ensure  => link,
    target  => "${uwsgi_dir}/apps-available/${app_url}.ini",
  }

  file { "/etc/nginx/sites-available/${app_url}.conf":
    ensure  => present,
    content => template('uwsgi/nginx-graphite-vhost.conf.erb'),
    require => File['/etc/nginx/uwsgi_params'],
  }->

  file { "/etc/nginx/sites-enabled/${app_url}.conf":
    ensure  => link,
    notify  => Service['nginx'],
    target  => "/etc/nginx/sites-available/${app_url}.conf",
  }

}

