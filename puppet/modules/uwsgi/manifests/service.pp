class uwsgi::service inherits uwsgi {

   service { 'uwsgi':
      ensure     => running,
      enable     => true,
      hasstatus  => false,
      hasrestart => false,
      require    => File['/etc/init/uwsgi.conf'],
  }
											       
}
