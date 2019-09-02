class prometheus::alertmanager::config inherits prometheus::alertmanager {

  systemd::service { $prometheus::params::alertmanger_service_name:
    description => 'Alert Manager',
    after_units => [ 'network-online.target' ],
    user        => 'alertmanager',
    restart     => 'on-failure',
    execstart   => "/opt/alertmanager-${prometheus::alertmanager::version}.linux-${prometheus::params::arch}/alertmanager",
  }

  # file { "/opt/alertmanager-${prometheus::alertmanager::version}.linux-${prometheus::params::arch}/alertmanager.yml":
  #   ensure  => 'present',
  #   owner   => 'prometheus',
  #   group   => 'prometheus',
  #   mode    => '0644',
  #   content => template("${module_name}/prometheus/prometheusyml.erb"),
  # }
  #
  # file { "/etc/prometheus.yml":
  #   ensure  => 'link',
  #   target  => "/opt/prometheus-${prometheus::alertmanager::version}.linux-${prometheus::params::arch}/prometheus.yml",
  #   require => File["/opt/prometheus-${prometheus::alertmanager::version}.linux-${prometheus::params::arch}/prometheus.yml"],
  # }

}
