# == Class: strongswan::roadwarrior
#
# Full description of class role here.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'strongswan::roadwarrior': }
#
class strongswan::roadwarrior (
  $conn_name,
  $ike           = undef,
  $esp           = undef,
  $keyexchange   = undef,
  $keyingtries   = undef,
  $ikelifetime   = undef,
  $lifetime      = undef,
  $margintime    = undef,
  $tfc           = undef,
  $closeaction   = undef,
  $dpdaction     = undef,
  $compress      = undef,
  $left          = '%any',
  $leftcert,
  $leftfirewall  = 'yes',
  $leftid,
  $leftkey,
  $leftkey_type,
  $leftsendcert  = undef,
  $leftsourceip  = '%config',
  $right,
  $rightid,
  $rightsendcert = undef,
  $rightsubnet,
) inherits strongswan {
  strongswan::snippet::ipsec_conf { $conn_name:
    ensure  => present,
    content => template("${module_name}/roadwarrior/ipsec.conf.erb"),
  }

  concat::fragment { $conn_name:
    target => $strongswan::ipsec_secrets,
    content => template("${module_name}/roadwarrior/ipsec.secrets.erb"),
  }
}
