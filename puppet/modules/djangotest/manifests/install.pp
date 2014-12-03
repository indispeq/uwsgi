class djangotest::install inherits djangotest {

  uwsgi::djangoapp { 'djangotest':
    app_url    => $app_url,
    app_venv   => $app_venv,
    app_module => $app_module,
    require    => Postgresql::Server::Db[$db_name],
  }

  postgresql::server::db { $db_name :
    user     => $db_user,
    password => postgresql_password($db_user, $db_password),
  }

}
