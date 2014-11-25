class djangotest::install inherits djangotest {

  uwsgi::djangoapp { 'djangotest':
    app_url    => $app_url,
    app_venv   => $app_venv,
    app_module => $app_module,
  }

}
