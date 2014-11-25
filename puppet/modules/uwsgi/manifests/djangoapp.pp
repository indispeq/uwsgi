# need to create app_path and also add right perms for probably www-data
define uwsgi::djangoapp (
  $app_url,
  $app_venv,
  $app_path = "${app_venv}/${app_module}",
  $wsgi_file = "${app_venv}/${app_module}/${app_module}/wsgi.py",
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

  python::pip { 'Django':
    ensure     => present,
    pkgname    => 'Django',
    require    => Python::Virtualenv[$app_venv],
    virtualenv => $app_venv,
    owner      => 'uwsgi',
  }

  exec { 'new-django-project':
    cwd     => $app_venv,
    command => "${app_venv}/bin/django-admin.py startproject ${app_module}",
    creates => $app_path,
  }

  file { "${uwsgi_dir}/apps-available/${app_url}.ini":
    ensure  => present,
    content => template('uwsgi/uwsgi-vassal.ini.erb'),
  }->

  file { "${uwsgi_dir}/apps-enabled/${app_url}.ini":
    ensure  => link,
    target  => "${uwsgi_dir}/apps-available/${app_url}.ini",
  }

  file { "${app_venv}/${app_module}/media":
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
  }->

  file { "${app_venv}/${app_module}/static":
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
  }->

  file { "/etc/nginx/sites-available/${app_url}.conf":
    ensure  => present,
    content => template('uwsgi/nginx-django-vhost.conf.erb'),
    require => File['/etc/nginx/uwsgi_params'],
  }->

  file { "/etc/nginx/sites-enabled/${app_url}.conf":
    ensure  => link,
    notify  => Service['nginx'],
    target  => "/etc/nginx/sites-available/${app_url}.conf",
  }

}

