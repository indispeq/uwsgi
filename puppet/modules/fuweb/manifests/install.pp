class fuweb::install inherits fuweb {
  uwsgi::app { 'fuweb':
    app_url    => $app_url,
    app_venv   => $app_venv,
    app_path   => $app_path,
    app_module => $app_module,
    wsgi_file  => $wsgi_file,
  }
}
