# == Define: strongswan::snippet
#
# This class allows for you to create a strongswan configuration file with
# whatever content you pass in.
#
# === Parameters
#
# [*content*] - The actual content to place in the file.
# [*ensure*]  - How to enforce the file (default: present)
#
# === Variables
#
# === Examples
#
#  strongswan::snippet { 'my-strongswan-config':
#    content => '<Some strongswan directive>',
#  }
#
define strongswan::snippet(
  $content,
  $ensure = 'present'
) {
  include strongswan

  file { "${strongswan::ipsec_conf_d}${name}.conf":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    content => "# This file is managed by Puppet, changes may be overwritten.\n${content}\n",
    require => Class['strongswan::config'],
    notify  => Class['strongswan::service'],
  }
}
