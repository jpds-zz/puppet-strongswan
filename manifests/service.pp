# == Class: strongswan::service
#
# This class enforces running of the strongswan service.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'strongswan::service': }
#
class strongswan::service {
  service { $strongswan::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => $strongswan::service_hasstatus,
    hasrestart => $strongswan::service_hasrestart,
    require    => Class['strongswan::config'],
  }
}
