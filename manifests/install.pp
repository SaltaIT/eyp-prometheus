class prometheus::install inherits prometheus {

  if($prometheus::manage_package)
  {
    package { $prometheus::params::package_name:
      ensure => $prometheus::package_ensure,
    }
  }

}
