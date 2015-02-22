# Default strongSwan parameters.
class strongswan::params {
  case $::osfamily {
    'Debian': {
      $package  = 'strongswan'
    }

    'RedHat': {
      $package  = 'strongswan'
    }

    default: {
      fail("${::osfamily} is not supported.")
    }
  }

  $service       = 'strongswan'
  $ipsec_d_dir   = '/etc/ipsec.d'
  $ipsec_conf    = '/etc/ipsec.conf'
  $ipsec_secrets = '/etc/ipsec.secrets'
}
