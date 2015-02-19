define strongswan::conn(
  $name = $title,
  $options = undef,
) {
  # The base class must be included first because it is used by parameter defaults
  if ! defined(Class['strongswan']) {
    fail('You must include the strongswan base class before using any strongswan defined resources')
  }

  validate_hash($options)

  concat::fragment { "${name}-conn":
    target  => "/etc/ipsec.conf",
    content => template('strongswan/ipsec/_conn.erb'),
  }
}
