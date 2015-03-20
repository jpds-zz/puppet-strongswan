# strongSwan charon class.
class strongswan::charon (
  $dns1                  = undef,
  $dns2                  = undef,
  $initiator_only        = 'no',
  $integrity_test        = 'no',
  $crypto_test_on_add    = 'no',
  $crypto_test_on_create = 'no',
  $crypto_test_required  = 'no',
  $crypto_test_rng_true  = 'no',
  $group                 = undef,
  $interfaces_use        = undef,
  $user                  = undef,
) inherits strongswan::params {
  # Check DNS setting IPs.
  if $dns1 {
    if !is_ip_address($dns1) {
      fail("Expected IP address for dns1, got ${dns1}")
    }
  }

  if $dns2 {
    if !is_ip_address($dns2) {
      fail("Expected IP address for dns2, got ${dns2}")
    }
  }

  file { 'charon.conf':
    ensure  => present,
    path    => $strongswan::params::charon_conf,
    content => template("${module_name}/charon.conf.erb"),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    require => Package[$strongswan::params::package],
    notify  => Class['Strongswan::Service'],
  }
}
