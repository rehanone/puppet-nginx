# To check the correct dependencies are set up for nginx.

require 'spec_helper'
describe 'nginx' do
  let(:facts) {{ :is_virtual => 'false' }}

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }
      describe "Testing the dependancies between the classes" do
        it { should contain_class('nginx::repo') }
        it { should contain_class('nginx::install') }
        it { should contain_class('nginx::config') }
        it { should contain_class('nginx::service') }
        it { should contain_class('nginx::firewall') }

        it { is_expected.to contain_class('nginx::repo').that_comes_before('Class[nginx::install]') }
        it { is_expected.to contain_class('nginx::install').that_comes_before('Class[nginx::config]') }
      end
    end
  end
end