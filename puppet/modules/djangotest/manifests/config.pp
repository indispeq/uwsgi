class djangotest::config (
  $app_path = "${app_venv}/${app_module}",
) inherits djangotest {

  file { "${app_path}/${app_module}/settings.py":
    ensure  => present,
    content => template('djangotest/settings.py.erb'),
    require => Exec['new-django-project'], 
  }

  exec { 'collectstatic':
    cwd     => $app_venv,
    command => "/bin/bash -c 'cd ${app_venv} && . bin/activate && cd ${app_path} && ./manage.py collectstatic --noinput'",
    require => File["${app_path}/${app_module}/settings.py"],
  }

}
