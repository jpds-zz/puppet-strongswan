# == Class: strongswan::config
#
# Full description of class role here.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'strongswan::config': }
#
class strongswan::config {
  file { $strongswan::strongswan_d:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    recurse => true,
    force   => true,
    require => Class['strongswan::install'],
  }

  file { $strongswan::ipsec_conf:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/ipsec.conf.erb"),
    require => Class['strongswan::install'],
    notify  => Class['strongswan::service'],
  }

  file { $strongswan::ipsec_conf_d:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    recurse => true,
    force   => true,
    require => Class['strongswan::install'],
  }

  file { $strongswan::ipsec_secrets:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/ipsec.secrets.erb"),
    require => Class['strongswan::install'],
    notify  => Class['strongswan::service'],
  }
}
