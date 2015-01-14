# == Class: strongswan::charon
#
# Full description of class role here.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'strongswan::charon': }
#
class strongswan::charon (
  $dns1                  = undef,
  $dns2                  = undef,
  $initiator_only        = "no",
  $integrity_test        = "no",
  $crypto_test_on_add    = "no",
  $crypto_test_on_create = "no",
  $crypto_test_required  = "no",
) inherits strongswan {

  # Check DNS setting IPs.
  if $dns1 {
    if !is_ip_address($dns1) { fail("Expect IP address for dns1, got ${dns1}") }
  }

  if $dns2 {
    if !is_ip_address($dns2) { fail("Expect IP address for dns2, got ${dns2}") }
  }

  strongswan::snippet::charon_conf { 'charon.conf':
    ensure  => present,
    content => template("${module_name}/charon.conf.erb"),
  }
}
