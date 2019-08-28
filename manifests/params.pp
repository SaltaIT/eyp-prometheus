class prometheus::params {

  $service_name='prometheus'
  $node_exporter_service_name='node_exporter'

  case $::architecture
  {
    'x86_64': { $arch='amd64' }
    'amd64':  { $arch='amd64' }
    default:  { $arch='amd64' }
  }

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^[7-8].*$/:
        {
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^1[68].*$/:
            {
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
