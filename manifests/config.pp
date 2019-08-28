class prometheus::config inherits prometheus {

  systemd::service { $prometheus::params::service_name:
    description   => 'Prometheus Server',
    documentation => 'https://prometheus.io/docs/introduction/overview/',
    after_units   => [ 'network-online.target' ],
    user          => 'prometheus',
    restart       => 'on-failure',
    execstart     => "/opt/prometheus-${prometheus::version}.linux-${prometheus::params::arch}/prometheus --config.file=/opt/prometheus/prometheus.yml --storage.tsdb.path=/opt/prometheus-data",
  }

  file { "/opt/prometheus-${prometheus::version}.linux-${prometheus::params::arch}/prometheus.yml":
    ensure  => 'present',
    owner   => 'prometheus',
    group   => 'prometheus',
    mode    => '0644',
    content => template("${module_name}/prometheus/prometheusyml.erb"),
  }

  file { "/etc/prometheus.yml":
    ensure  => 'link',
    target  => "/opt/prometheus-${prometheus::version}.linux-${prometheus::params::arch}/prometheus.yml",
    require => File["/opt/prometheus-${prometheus::version}.linux-${prometheus::params::arch}/prometheus.yml"],
  }

}
