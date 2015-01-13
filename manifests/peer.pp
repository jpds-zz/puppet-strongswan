# == Class: strongswan::peer
#
# Full description of class role here.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'strongswan::peer': }
#
class strongswan::peer (
  $conn_name,
  $ike,
  $esp,
  $keyexchange,
  $keyingtries,
  $ikelifetime,
  $lifetime,
  $margintime,
  $closeaction,
  $dpdaction,
  $compress,
  $left,
  $leftcert,
  $leftkey,
  $leftkey_type,
  $leftid,
  $leftfirewall,
  $leftsubnet,
  $right,
  $rightauth,
  $rightid,
  $rightsubnet,
  $auto,
) inherits strongswan {
  strongswan::snippet::ipsec_conf { $conn_name:
    ensure  => present,
    content => template("${module_name}/peer/ipsec.conf.erb"),
  }

  concat::fragment { $conn_name:
    target => $strongswan::ipsec_secrets,
    content => template("${module_name}/peer/ipsec.secrets.erb"),
  }
}
