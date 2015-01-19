# == Class: strongswan::gateway
#
# Full description of class role here.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'strongswan::gateway': }
#
class strongswan::gateway (
  $conn_name,
  $ike         = undef,
  $esp         = undef,
  $keyexchange = undef,
  $ikelifetime = undef,
  $lifetime    = undef,
  $margintime  = undef,
  $tfc         = undef,
  $closeaction = undef,
  $dpdaction   = undef,
  $compress    = undef,
  $left,
  $leftcert,
  $leftkey,
  $leftkey_type,
  $leftid,
  $leftfirewall,
  $leftsubnet,
  $right,
  $rightauth,
  $rightsourceip,
) inherits strongswan {
  strongswan::snippet::ipsec_conf { $conn_name:
    ensure  => present,
    content => template("${module_name}/gateway/ipsec.conf.erb"),
  }

  concat::fragment { $conn_name:
    target => $strongswan::ipsec_secrets,
    content => template("${module_name}/gateway/ipsec.secrets.erb"),
  }
}
