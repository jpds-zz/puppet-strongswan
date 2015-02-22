require 'spec_helper'

describe 'strongswan::charon', :type => 'class' do
  context "on a Debian OS" do
    let :facts do
      {
        :osfamily       => 'Debian',
      }
    end

    it {
      should contain_file('charon.conf').with(
        "ensure"  => "present",
        "path"    => "/etc/strongswan.d/charon.conf",
        "mode"    => '0644',
        "owner"   => 'root',
        "group"   => 'root',
        "require" => "Package[strongswan]",
        "notify"  => "Class[Strongswan::Service]",
      )
    }

    context "with setup options set" do
      let :params do
        {
          :dns1 => '8.8.8.8',
        }
      end

      it {
        should contain_file('charon.conf') \
          .with_content(/^    dns1 = 8.8.8.8$/)
      }
      it {
        should contain_file('charon.conf') \
          .without_content(/^    dns2 = 8.8.8.8$/)
      }
    end
  end
end
