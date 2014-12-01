class logster::install inherits logster {

  python::virtualenv { $logster_venv :
    ensure     => present,
    version    => 'system',
    systempkgs => true,
    owner      => 'root',
    group      => 'staff',
  }->

  package { 'logcheck':
    ensure => installed,
  }->

  python::pip { 'logster' :
    ensure     => present,
    pkgname    => 'logster',
    virtualenv => $logster_venv,
    url        => 'git+https://github.com/etsy/logster@370d5683e6ad2e9499e3149fe75417cd92e2ea2c#egg=logster',
  }

}

