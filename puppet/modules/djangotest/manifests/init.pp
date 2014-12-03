class djangotest (
  $app_url = $djangotest::params::app_url, 
  $app_venv = $djangotest::params::app_venv,
  $app_module = $djangotest::params::app_module,
  $db_name = $djangotest::params::db_name,
  $db_user = $djangotest::params::db_user,
  $db_password = $djangotest::params::db_password,
) inherits djangotest::params {
  class {'::djangotest::install': }->
  class {'::djangotest::config': }->
  class {'::djangotest::service': }
}
