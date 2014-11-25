# need to create app_path and also add right perms for probably www-data
define uwsgi::app (
  $app_url,
  $app_venv,
  $app_path,
  $wsgi_file,
  $app_module,
  $uwsgi_dir = hiera('uwsgi::uwsgi_dir'),
) {

  python::virtualenv { $app_venv :
    ensure  => present,
    version => 'system',
    owner   => 'uwsgi',
    group   => 'staff',
    require => Class['uwsgi'],
  }

  file { $app_path :
    ensure  => directory,
    owner   => 'uwsgi',
    group   => 'staff',
    require => Python::Virtualenv[$app_venv],
  }

  file { "${app_path}/${wsgi_file}" :
    ensure  => present,
    require => File[$app_path],
    source  => "puppet:///modules/${app_module}/${wsgi_file}",
  }

  file { "${uwsgi_dir}/apps-available/${app_url}.ini":
    ensure  => present,
    content => template('uwsgi/uwsgi-vassal.ini.erb'),
  }->

  file { "${uwsgi_dir}/apps-enabled/${app_url}.ini":
    ensure  => link,
    target  => "${uwsgi_dir}/apps-available/${app_url}.ini",
  }

  file { "/etc/nginx/sites-available/${app_url}.conf":
    ensure  => present,
    content => template('uwsgi/nginx-vhost.conf.erb'),
    require => File['/etc/nginx/uwsgi_params'],
  }->

  file { "/etc/nginx/sites-enabled/${app_url}.conf":
    ensure  => link,
    notify  => Service['nginx'],
    target  => "/etc/nginx/sites-available/${app_url}.conf",
  }

}

