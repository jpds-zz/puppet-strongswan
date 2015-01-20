# == Class: strongswan::default
#
# Full description of class role here.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'strongswan::default': }
#
class strongswan::default (
  $ike         = undef,
  $esp         = undef,
  $keyexchange = undef,
  $keyingtries = undef,
  $ikelifetime = undef,
  $lifetime    = undef,
  $margintime  = undef,
  $tfc         = undef,
  $closeaction = undef,
  $dpdaction   = undef,
  $compress    = undef,
) inherits strongswan {
  strongswan::snippet::ipsec_conf { 'default':
    ensure  => present,
    content => template("${module_name}/default/ipsec.conf.erb"),
  }
}
