# == Class: strongswan::roadwarrior
#
# Full description of class role here.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'strongswan::roadwarrior': }
#
class strongswan::roadwarrior (
  $conn_name,
  $left,
  $leftcert,
  $leftid,
  $leftsourceip,
  $right,
  $rightid,
  $rightsubnet,
) inherits strongswan {
  if $custom_config {
    $content_real = template($custom_config)
  } else {
    $content_real = template("${module_name}/roadwarrior/ipsec.conf.erb")
  }

  strongswan::snippet { $conn_name:
    ensure  => present,
    content => $content_real,
  }
}
