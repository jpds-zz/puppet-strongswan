# puppet-strongswan

This Puppet module contains configurations for strongswan.

## Build status

[![Build Status](https://travis-ci.org/jpds/puppet-strongswan.svg?branch=master)](https://travis-ci.org/jpds/puppet-strongswan)

## Example usage

strongSwan can be installed simply by:

```puppet
include strongswan
```

### Default configuration

*conn %default* configurations can be set as follows, please note that while this is a working example, it should be adjusted according to your requirements:

```puppet
strongswan::conn { '%default':
  options => {
    "ike"         => "aes128gcm128-prfsha256-ecp256!",
    "esp"         => "aes128gcm128-ecp256!",
    "keyexchange" => "ikev2",
    "ikelifetime" => "60m",
    "lifetime"    => "20m",
    "margintime"  => "3m",
    "closeaction" => "restart",
    "dpdaction"   => "restart",
    "compress"    => "no",
  }
}
```

### Peer configuration

Parameters for an IPsec peer with pregenerated certificate - replace the certificate with your own:

```puppet
strongswan::conn { 'peer':
  options => {
    "left"         => "10.0.1.1",
    "leftcert"     => 'peerCert.der',
    "leftfirewall" => 'no',
    "leftid"       => '"C=UK, CN=Peer 1"',
    "leftsubnet"   => "10.0.1.0/24",
    "right"        => '10.0.2.1',
    "rightauth"    => 'pubkey',
    "rightid"      => '"C=UK, CN=Peer 2"',
    "rightsubnet"  => '10.0.2.0/24',
    "auto"         => "start",
  }
}

strongswan::secrets { 'peer':
  options => {
    'ECDSA'        => 'peerKey.der',
  }
}
```

Parameters for an IPsec peer with pre-shared key - replace the key string with your own:

```puppet
strongswan::conn { 'peer':
  options => {
    "left"         => "10.0.1.1",
    "leftfirewall" => 'no',
    "leftid"       => '"C=UK, CN=Peer 1"',
    "leftsubnet"   => "10.0.1.0/24",
    "right"        => '10.0.2.1',
    "rightid"      => '"C=UK, CN=Peer 2"',
    "rightsubnet"  => '10.0.2.0/24',
    "authby"       => 'psk',
    "auto"         => "start",
  }
}

strongswan::secrets { 'peer':
  leftid => '"C=UK, CN=Peer 1"',
  rightid => '"C=UK, CN=Peer 2"',
  auth => 'PSK',
  'key' => 'a string of your choice',
}
```



### Gateway configuration

Parameters for an IPsec gateway server:
```puppet
strongswan::conn { 'gateway':
  options => {
    "left"          => '%any',
    "leftcert"      => 'gwCert.der',
    "leftfirewall"  => "yes",
    "leftid"        => '"C=UK, CN=GW"',
    "leftsubnet"    => '10.0.0.0/24',
    "right"         => '%any',
    "rightauth"     => "pubkey",
    "rightsourceip" => '10.0.1.0/24',
    "auto"          => 'add',
  }
}

strongswan::secrets { 'peer':
  options => {
    'ECDSA'         => 'gwKey.der',
  }
}
```

Gateway charon configuration:

```puppet
class { 'strongswan::charon':
  dns1                    => '10.0.0.5',
  initiator_only          => 'no',
  integrity_test          => 'yes',
  group                   => 'nogroup',
  user                    => 'strongswan',
  retransmit_base         => '1.1',
  retransmit_tries        => '30',
  retransmit_timeout      => '3.0',
  retry_initiate_interval => '1.0',
  keep_alive              => '10s',
}
```

**Note**: This module is solely intended to handle the strongswan components of
the system. Other parts of the infrastructure, such as *iptables* and *sysctl*,
are to be managed by their respective modules. The following will enable packet
forwarding on the gateway node, for instance:

```puppet
sysctl { 'net.ipv4.ip_forward': value => '1' }
```

### Roadwarrior configuration

Parameters for an IPsec roadwarrior connection:

```puppet
strongswan::conn { 'roadwarrior':
  options => {
    "keyingtries"  => "%forever",
    "left"         => '%any',
    "leftcert"     => 'rwCert.der',
    "leftid"       => '"C=UK, CN=rw"',
    "right"        => '10.0.0.1',
    "rightid"      => '"C=UK, CN=GW"',
    "rightsubnet"  => '0.0.0.0/0',
    "auto"         => 'start',
  }
}

strongswan::secrets { 'roadwarrior':
  options => {
    'ECDSA'        => 'rwKey.der',
  }
}
```

charon daemon configuration can also be adjusted, for example, for a client
configuration:

```puppet
class { 'strongswan::charon':
  initiator_only        => "yes",
  integrity_test        => "yes",
  crypto_test_on_add    => "yes",
  crypto_test_on_create => "yes",
  crypto_test_required  => "yes",
}
```

### Setup configuration

The IPsec 'config setup' section can be configured as follows:

```puppet
class { 'strongswan::setup':
  options => {
    'strictcrlpolicy' => 'yes',
    'charondebug'     => '"ike 2, knl 3, cfg 0"'
  }
}
```

## License

See [LICENSE](LICENSE) file.

