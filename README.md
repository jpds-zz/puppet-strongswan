# puppet-strongswan

This Puppet module contains configurations for strongSwan.

## Example usage

### Peer configuration

Parameters for an IPsec peer:

```
class { 'strongswan::peer':
  conn_name    => 'peer',
  ike          => "aes128gcm128-prfsha256-ecp256!",
  esp          => "aes128gcm128-ecp256!",
  keyexchange  => "ikev2",
  keyingtries  => "%forever",
  ikelifetime  => "60m",
  lifetime     => "20m",
  margintime   => "3m",
  closeaction  => "restart",
  dpdaction    => "restart",
  compress     => "yes",
  left         => "10.0.1.1",
  leftcert     => 'peerCert.der',
  leftfirewall => 'no',
  leftkey      => 'peerKey.der',
  leftkey_type => 'ECDSA',
  leftid       => "O=UK, CN=Peer 1",
  leftsubnet   => "10.0.1.0/24",
  right        => '10.0.2.1',
  rightauth    => 'pubkey',
  rightid      => "O=UK, CN=Peer 2",
  rightsubnet  => '10.0.2.0/24',
  auto         => "start",
```

### Gateway configuration

Parameters for a IPsec gateway server:
```
class { 'strongswan::gateway':
  conn_name      => 'vpn-gw',
  ike            => "aes128gcm128-prfsha256-ecp256!",
  esp            => "aes128gcm128-ecp256!",
  keyexchange    => "ikev2",
  keyingtries    => "%forever",
  ikelifetime    => "60m",
  lifetime       => "20m",
  margintime     => "3m",
  tfc            => "%mtu",
  closeaction    => "restart",
  dpdaction      => "restart",
  compress       => "yes",
  left           => '%any',
  leftcert       => 'gwCert.der',
  leftfirewall   => "yes",
  leftkey        => 'gwKey.der',
  leftkey_type   => 'ECDSA',
  leftid         => "C=UK, CN=GW",
  leftsubnet     => '10.0.0.0/24',
  right          => '%any',
  rightauth      => "pubkey",
  rightsourceip  => '10.0.1.0/24',
}
```

### Roadwarrior configuration

Parameters for a IPsec roadwarrior connection:
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
