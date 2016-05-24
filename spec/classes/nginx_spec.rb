require 'spec_helper'

describe 'nginx' do
  let :facts do
    {
      :operatingsystem => 'Archlinux',
    }
  end

  describe "with defaults" do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('nginx') }
    it { is_expected.to contain_anchor('nginx::begin') }
    it { is_expected.to contain_nginx__repo.that_requires('Anchor[nginx::begin]') }
    it { is_expected.to contain_nginx__config.that_requires('Class[nginx::repo]') }
    it { is_expected.to contain_nginx__service.that_subscribes_to('Class[nginx::config]') }
    it { is_expected.to contain_nginx__firewall.that_requires('Class[nginx::service]') }
    it { is_expected.to contain_anchor('nginx::end').that_requires('Class[nginx::service]') }
  end
end
