require 'spec_helper'

describe 'nginx' do
  let(:facts) {{ :is_virtual => 'false' }}

  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }

      describe 'nginx::install' do
        let(:params) {{ :package_ensure => 'present', :package_name => 'nginx', :package_manage => true, }}

        it { should contain_package('nginx').with(
          :ensure => 'present'
        )}

        describe 'should allow package ensure to be overridden' do
          let(:params) {{ :package_ensure => 'latest', :package_name => 'nginx', :package_manage => true, }}
          it { should contain_package('nginx').with_ensure('latest') }
        end

        describe 'should allow the package name to be overridden' do
          let(:params) {{ :package_ensure => 'present', :package_name => 'hambaby', :package_manage => true, }}
          it { should contain_package('hambaby') }
        end

        describe 'should allow the package to be unmanaged' do
          let(:params) {{ :package_manage => false, :package_name => 'nginx', }}
          it { should_not contain_package('nginx') }
        end
      end

      describe 'nginx::config' do

        describe 'should provide default install location' do

          it { should contain_file('/etc/nginx/sites-enabled').with(
            :ensure  => 'directory',
            :purge   => false,
            :recurse => true
          )}

          it { should contain_file('/etc/nginx/certs').with(
            :ensure => 'directory',
            :mode   => '0600',
            :owner  => 'root',
            :group  => 'root'
          )}
        end

        describe 'should allow install location to be overridden' do
          let(:params) {{ :install_location => '/opt/nginx-server', }}

          it { should contain_file('/opt/nginx-server/sites-enabled').with(
            :ensure  => 'directory',
            :purge   => false,
            :recurse => true
          )}

          it { should contain_file('/opt/nginx-server/certs').with(
            :ensure => 'directory',
            :mode   => '0600',
            :owner  => 'root',
            :group  => 'root'
          )}
        end
      end

      describe 'nginx::service' do

        describe 'should provide default service params' do

          it { should contain_service('nginx').with(
            :ensure => 'running',
            :enable => true,
            :name   => 'nginx'
          )}
        end

        describe 'should allow service params to be overridden' do
          let(:params) {{ :service_name => 'nginx-service', :service_ensure => 'stopped', :service_enable => false, }}

          it { should contain_service('nginx-service').with(
            :ensure => 'stopped',
            :enable => false,
            :name   => 'nginx-service'
          )}
        end

        describe 'should allow the service to be unmanaged' do
          let(:params) {{ :service_manage => false, }}
          it { should_not contain_service('nginx') }
        end
      end
    end
  end
end
