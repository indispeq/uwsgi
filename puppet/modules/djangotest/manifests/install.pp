class djangotest::install inherits djangotest {

  uwsgi::djangoapp { 'djangotest':
    app_url    => $app_url,
    app_venv   => $app_venv,
    app_module => $app_module,
  }

#  postgresql::server::db { $django_db_name :
#    user     => $django_db_user,
#    password => postgresql_password($django_db_user, $django_db_password),
#  }

}
