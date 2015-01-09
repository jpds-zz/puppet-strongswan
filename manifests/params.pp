# == Class: strongswan::params
#
# This defines default configuration values for strongswan.
# You don't want to use it directly.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'strongswan::params': }
#
class strongswan::params {
  $run_user = $::operatingsystem ? {
    'Ubuntu' => 'root',
    default  => 'root',
  }

  case $::osfamily {
    debian: {
      case $::operatingsystem {
        'Debian': {
          $run_group = 'root'
        }
        'Ubuntu': {
          $run_group = 'root'
        }
      }
      $strongswan_package_name   = 'strongswan'
      $package_status         = 'latest'
      $strongswan_d           = '/etc/strongswan.d/'
      $charon_conf            = '/etc/strongswan.d/charon.conf'
      $ipsec_conf             = '/etc/ipsec.conf'
      $ipsec_conf_d           = '/etc/ipsec.conf.d/'
      $ipsec_secrets          = '/etc/ipsec.secrets'
      $perm_file              = '0640'
      $perm_dir               = '0755'
      $service_name           = 'strongswan'
      $service_hasrestart     = true
      $service_hasstatus      = true
    }
    default: {
        fail("The ${module_name} module is not supported on ${::osfamily}/${::operatingsystem}.")
    }
  }
}
