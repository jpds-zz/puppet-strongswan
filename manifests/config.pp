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
    mode    => '0644',
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

  concat { $strongswan::ipsec_secrets:
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => Class['strongswan::install'],
    notify  => Class['strongswan::service'],
  }

  concat::fragment { 'ipsec_secrets_ipsec_header':
    target  => $strongswan::ipsec_secrets,
    content => "#\n# /etc/ipsec.secrets - strongSwan IPsec secrets configuration file.\n#\n",
    order   => '01',
  }

  concat::fragment { 'ipsec_secrets_strongswan_header':
    target  => $strongswan::ipsec_secrets,
    content => "# This file is managed by Puppet.\n#\n\n",
    order   => '02',
  }
}
