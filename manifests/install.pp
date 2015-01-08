# == Class: strongswan::install
#
# This class makes sure that the required packages are installed
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'strongswan::install': }
#
class strongswan::install {
  if $strongswan::strongswan_package_name != false {
    package { $strongswan::strongswan_package_name:
      ensure => $strongswan::package_status,
    }
  }
}
