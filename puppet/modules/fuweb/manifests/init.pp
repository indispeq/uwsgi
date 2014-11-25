class fuweb (
  $app_url = $fuweb::params::app_url, 
  $app_venv = $fuweb::params::app_venv,
  $wsgi_file = $fuweb::params::wsgi_file,
  $app_module = $fuweb::params::app_module,
) inherits fuweb::params {
  class {'::fuweb::install': }->
  class {'::fuweb::config': }->
  class {'::fuweb::service': }
}
