# Configure a strongSwan secrets configuration.
define strongswan::secrets(
  $secrets_name = $title,
  $options = {},
  $leftid = undef,
  $rightid = undef,
  $auth = undef,
  $key = undef,
) {
  # The base class must be included first because it is used by parameter
  # defaults.
  if ! defined(Class['strongswan']) {
    fail('You must include the strongswan base class before using any strongswan defined resources')
  }

  validate_hash($options)

  concat::fragment { "ipsec_secrets_secret-${secrets_name}":
    ensure  => present,
    content => template('strongswan/ipsec_secrets_secret.erb'),
    target  => $strongswan::params::ipsec_secrets,
    order   => '02',
  }
}
