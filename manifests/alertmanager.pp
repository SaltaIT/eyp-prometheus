class prometheus::alertmanager(
                            $manage_package        = true,
                            $package_ensure        = 'installed',
                            $manage_service        = true,
                            $manage_docker_service = true,
                            $service_ensure        = 'running',
                            $service_enable        = true,
                            $srcdir                = '/usr/local/src',
                            $version               = '0.18.0',
                          ) inherits prometheus::params{

  class { '::prometheus::alertmanager::install': }
  -> class { '::prometheus::alertmanager::config': }
  ~> class { '::prometheus::alertmanager::service': }
  -> Class['::prometheus::alertmanager']

}
