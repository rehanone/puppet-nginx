require 'spec_helper'

describe 'nginx' do
  let :facts do
    {
      :operatingsystem => 'Archlinux',
    }
  end

  it { is_expected.to compile.with_all_deps }

  context 'with default values for all parameters' do
    it { should contain_class('nginx::repo') }
    it { should contain_class('nginx::install') }
    it { should contain_class('nginx::config') }
    it { should contain_class('nginx::service') }
    it { should contain_class('nginx::firewall') }
  end
end
