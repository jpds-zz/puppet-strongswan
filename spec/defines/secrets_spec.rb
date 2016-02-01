require 'spec_helper'

describe 'strongswan::secrets', :type => :define do
  let :pre_condition do
    'include strongswan'
  end

  context 'on a Debian system' do
    let(:facts) {
      {
        :id             => 'root',
        :is_pe          => false,
        :osfamily       => 'Debian',
        :concat_basedir => '/dne',
        :path           => '/usr/sbin:/usr/bin:/sbin:/bin',
      }
    }

    context 'with certificate based authentication' do
      let(:title) { 'rw' }
      let :params do
        {
          :options => {
            'ECDSA'  => 'rwKey.der',
          },
        } 
      end

      it { should contain_class('strongswan::params') }

      it {
        should contain_concat__fragment('ipsec_secrets_secret-rw').with_content(/# Secrets for rw\./)
      }

      it {
        should contain_concat__fragment('ipsec_secrets_secret-rw').with_content(/: ECDSA rwKey\.der/)
      }
    end

    context 'with pre-shared-key authentication' do
      let(:title) { 'ABC-XYZ-vpn' }
      let :params do
        {
          'leftid'      => '@ABC',
          'rightid'     => '@XYZ',
          'auth'        => 'PSK',
          'key'         => 'a long string'
        } 
      end
      it { should contain_class('strongswan::params') }
      it {
        should contain_concat__fragment('ipsec_secrets_secret-ABC-XYZ-vpn').with_content(/# Secrets for ABC-XYZ-vpn\./)
      }

      it {
        should contain_concat__fragment('ipsec_secrets_secret-ABC-XYZ-vpn').with_content(/@ABC @XYZ : PSK a long string/)
      }
    end

  end

  context 'example settings on a Solaris system' do
    let(:facts) { { :osfamily => 'Solaris' } }
    let(:title) { 'gw' }

    it do
      expect {
        should compile
      }.to raise_error(/Solaris is not supported./)
    end
  end
end
