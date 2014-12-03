class graphitetest::install inherits graphitetest {

  uwsgi::graphiteapp { 'graphitetest':
    app_url    => $app_url,
    app_path   => $app_path,
    app_module => $app_module,
    app_venv   => $app_venv,
    require    => Postgresql::Server::Db[$db_name],
  }

  postgresql::server::db { $db_name :
    user     => $db_user,
    password => postgresql_password($db_user, $db_password),
  }

}
