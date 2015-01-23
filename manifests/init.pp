# == Class: strongswan
#
# Meta class to install strongswan with a basic configuration.
# You probably want strongswan::roadwarrior or strongswan::gateway or
# strongswan::peer
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'strongswan': }
#
class strongswan
{
  include strongswan::params
  class { 'strongswan::install': }
  class { 'strongswan::config': }
  class { 'strongswan::service': }
}
