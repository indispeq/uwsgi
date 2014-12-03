# need to create app_path and also add right perms for probably www-data
define uwsgi::graphiteapp (
  $app_url,
  $app_path,
  $app_module,
  $app_venv,
  $graphite_log_dir = '/opt/graphite-logs',
  $uwsgi_dir = hiera('uwsgi::uwsgi_dir'),
) {

  file { $graphite_log_dir :
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0770',
    recurse => true,
  }

  file { "${uwsgi_dir}/apps-available/${app_url}.ini":
    ensure  => present,
    content => template('uwsgi/uwsgi-graphite-vassal.ini.erb'),
    require => Package['graphite-web'],
    notify  => Exec['refresh-app'],
  }->

  file { "${uwsgi_dir}/apps-enabled/${app_url}.ini":
    ensure  => link,
    target  => "${uwsgi_dir}/apps-available/${app_url}.ini",
  }

  exec { 'refresh-app':
    command     => "/usr/bin/touch --no-dereference ${uwsgi_dir}/apps-enabled/${app_url}.ini",
    require     => File["${uwsgi_dir}/apps-enabled/${app_url}.ini"],
    refreshonly => true,
#    subscribe   => Exec['graphite-manage-syncdb-perms'],
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

