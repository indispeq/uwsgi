class graphitetest::params {

  $db_user = hiera('graphite::db_user')
  $db_password = hiera('graphite::db_password')
  $db_name = hiera('graphite::db_name')

}
