require 'spec_helper'

describe 'strongswan::conn', :type => :define do
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

    context 'with default conn settings' do
      let(:title) { '%default' }
      let :params do
        {
          :options => {
            'ike'         => 'aes128gcm128-prfsha256-ecp256!',
            'esp'         => 'aes128gcm128-ecp256!',
            'keyexchange' => 'ikev2',
          },
        } 
      end
      it { should contain_class('strongswan::params') }
      it {
        should contain_concat__fragment('ipsec_conf_conn-%default').with_content(/^conn %default$/)
      }
      it {
        should contain_concat__fragment('ipsec_conf_conn-%default').with_content(/    ike=aes128gcm128-prfsha256-ecp256/)
      }
      it {
        should contain_concat__fragment('ipsec_conf_conn-%default').with_content(/    esp=aes128gcm128-ecp256/)
      }
      it {
        should contain_concat__fragment('ipsec_conf_conn-%default').with_content(/    keyexchange=ikev2/)
      }
    end


    context 'with test conn settings' do
      let(:title) { 'ABC_XYZ' }
      let :params do
        {
          :options => {
            'left'          => '1.2.3.4',
            'leftsubnet'    => '1.2.3.0/24',
            'leftid'        => '@ABC',
            'right'         => '10.20.30.40',
            'rightsubnet'   => '5.6.7.0/24',
            'rightid'       => '@XYZ',
            'authby'        => 'psk',
          },
        } 
      end
      it { should contain_class('strongswan::params') }
      it {
        should contain_concat__fragment('ipsec_conf_conn-ABC_XYZ').with_content(/^conn ABC_XYZ$/)
      }
      it {
        should contain_concat__fragment('ipsec_conf_conn-ABC_XYZ').with_content(/    left=1.2.3.4/)
      }
      it {
        should contain_concat__fragment('ipsec_conf_conn-ABC_XYZ').with_content(/    leftid=@ABC/)
      }
      it {
        should contain_concat__fragment('ipsec_conf_conn-ABC_XYZ').with_content(/    right=10.20.30.40/)
      }
      it {
        should contain_concat__fragment('ipsec_conf_conn-ABC_XYZ').with_content(/    rightsubnet=5.6.7.0\/24/)
      }
      it {
        should contain_concat__fragment('ipsec_conf_conn-ABC_XYZ').with_content(/    rightid=@XYZ/)
      }
      it {
        should contain_concat__fragment('ipsec_conf_conn-ABC_XYZ').with_content(/    authby=psk/)
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
