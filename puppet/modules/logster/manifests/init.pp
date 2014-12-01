class logster (

  $logster_venv = $logster::params::logster_venv,

) inherits logster::params {
  class {'::logster::install': }
}

