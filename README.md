# puppet-strongswan

This Puppet module contains configurations for strongSwan.

## Example usage

### Roadwarrior configuration

Parameters for the IPsec connection:
```
class { 'strongswan::roadwarrior':
  conn_name    => 'rw-vpn',
  ike          => "aes128gcm128-prfsha256-ecp256!",
  esp          => "aes128gcm128-ecp256!",
  keyexchange  => "ikev2",
  keyingtries  => "%forever",
  ikelifetime  => "60m",
  lifetime     => "20m",
  margintime   => "3m",
  tfc          => "%mtu",
  closeaction  => "restart",
  dpdaction    => "restart",
  compress     => "yes",
  leftcert     => 'rwCert.der',
  leftkey      => 'rwKey.der',
  leftkey_type => 'ECDSA',
  leftid       => "C=UK, CN=rw",
  right        => '10.0.0.1',
  rightid      => "C=UK, CN=GW",
  rightsubnet  => '0.0.0.0/0',
}
```

Example charon daemon configuration:

```
class { 'strongswan::charon':
  initiator_only => "yes",
}
```

## License

See [LICENSE](LICENSE) file.
