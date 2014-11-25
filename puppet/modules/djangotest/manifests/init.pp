class djangotest (
  $app_url = $djangotest::params::app_url, 
  $app_venv = $djangotest::params::app_venv,
  $app_module = $djangotest::params::app_module,
) inherits djangotest::params {
  class {'::djangotest::install': }->
  class {'::djangotest::config': }->
  class {'::djangotest::service': }
}
