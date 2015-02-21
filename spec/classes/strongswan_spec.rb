require 'spec_helper'

describe 'strongswan', :type => 'class' do
  context "on a Debian OS" do
    let :facts do
      {
        :osfamily       => 'Debian',
        :concat_basedir => '/dne',
      }
    end

    it { should compile }
    it {
      should contain_package('strongswan') \
        .that_comes_before('File[ipsec.d]')
      should contain_package('strongswan') \
        .that_comes_before('Concat[/etc/ipsec.conf]')
    }
    it { should contain_file('ipsec.d').with(
        'ensure' => 'directory',
        'path'   => '/etc/ipsec.d',
        'mode'   => '0755',
        'owner'  => 'root',
        'group'  => 'root',
      )
    }
    it {
      should contain_concat('/etc/ipsec.conf').with(
        'ensure' => 'present',
        'mode'   => '0644',
        'owner'  => 'root',
        'group'  => 'root',
        'notify' => 'Class[Strongswan::Service]',
      )
    }
  end

  context "on a Red Hat OS" do
    let :facts do
      {
        :osfamily       => 'RedHat',
        :concat_basedir => '/dne',
      }
    end

    it { should compile }
    it {
      should contain_package('strongswan') \
        .that_comes_before('File[ipsec.d]')
      should contain_package('strongswan') \
        .that_comes_before('Concat[/etc/ipsec.conf]')
    }
    it { should contain_file('ipsec.d').with(
        'ensure' => 'directory',
        'path'   => '/etc/ipsec.d',
        'mode'   => '0755',
        'owner'  => 'root',
        'group'  => 'root',
      )
    }
    it {
      should contain_concat('/etc/ipsec.conf').with(
        'ensure' => 'present',
        'mode'   => '0644',
        'owner'  => 'root',
        'group'  => 'root',
        'notify' => 'Class[Strongswan::Service]',
      )
    }
  end

  context "on an unknown OS" do
    let :facts do
      {
        :osfamily => 'Darwin'
      }
    end

    it {
      expect { should raise_error(Puppet::Error) }
    }
  end

end
