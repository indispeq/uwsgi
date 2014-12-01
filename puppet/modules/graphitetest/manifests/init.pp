class graphitetest (
  $app_url = $graphitetest::params::app_url, 
  $app_path = $graphitetest::params::app_path,
  $app_module = $graphitetest::params::app_module,
  $app_venv = $graphitetest::params::app_venv,
) inherits graphitetest::params {
  class {'::graphitetest::install': }->
  class {'::graphitetest::config': }->
  class {'::graphitetest::service': }
}
