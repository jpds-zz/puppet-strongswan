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
  $dns1                  = "",
  $dns2                  = "",
  $initiator_only        = "no",
  $integrity_test        = "no",
  $crypto_test_on_add    = "no",
  $crypto_test_on_create = "no",
  $crypto_test_required  = "no",
) inherits strongswan {
  strongswan::snippet::charon_conf { 'charon.conf':
    ensure  => present,
    content => template("${module_name}/charon.conf.erb"),
  }
}
