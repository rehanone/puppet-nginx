# To check the correct dependencies are set up for nginx.

require 'spec_helper'
describe 'nginx' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it {
        is_expected.to compile.with_all_deps
      }

      describe 'Testing the dependancies between the classes' do
        it { is_expected.to contain_class('nginx::repo') }
        it { is_expected.to contain_class('nginx::install') }
        it { is_expected.to contain_class('nginx::config') }
        it { is_expected.to contain_class('nginx::service') }
        it { is_expected.to contain_class('nginx::firewall') }

        it { is_expected.to contain_class('nginx::repo').that_comes_before('Class[nginx::install]') }
        it { is_expected.to contain_class('nginx::install').that_comes_before('Class[nginx::config]') }
      end
    end
  end
end
