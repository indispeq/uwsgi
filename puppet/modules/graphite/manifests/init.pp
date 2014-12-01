class graphite (
  $secret_key  = $graphite::params::secret_key,
  $db_name     = $graphite::params::db_name,
  $db_user     = $graphite::params::db_user,
  $db_password = $graphite::params::db_password,
  $db_host     = $graphite::params::db_host,
) inherits graphite::params {

  class { '::graphite::install': }->
  class { '::graphite::carbon': }

}

