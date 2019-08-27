class prometheus::service inherits prometheus {

  #
  validate_bool($prometheus::manage_docker_service)
  validate_bool($prometheus::manage_service)
  validate_bool($prometheus::service_enable)

  validate_re($prometheus::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${prometheus::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $prometheus::manage_docker_service)
  {
    if($prometheus::manage_service)
    {
      service { $prometheus::params::service_name:
        ensure => $prometheus::service_ensure,
        enable => $prometheus::service_enable,
      }
    }
  }
}
