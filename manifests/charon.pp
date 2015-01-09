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
  $initiator_only = "no",
  $integrity_test = "no",
) inherits strongswan {
  strongswan::snippet::charon_conf { 'charon.conf':
    ensure  => present,
    content => template("${module_name}/charon.conf.erb"),
  }
}
