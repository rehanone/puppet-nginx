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
    it { is_expected.to contain_nginx__repo }
    it { is_expected.to contain_nginx__config }
    it { is_expected.to contain_nginx__service }
    it { is_expected.to contain_nginx__firewall }
    it { is_expected.to contain_anchor('nginx::end') }
  end
end
