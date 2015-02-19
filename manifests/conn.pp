define strongswan::conn(
  $name = $title,
  $options = undef,
) {
  # The base class must be included first because it is used by parameter defaults
  if ! defined(Class['strongswan']) {
    fail('You must include the strongswan base class before using any strongswan defined resources')
  }
}
