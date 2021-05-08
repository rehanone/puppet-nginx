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

      describe 'nginx::repo' do
        let(:params) do
          {
            repo_manage: true,
            repo_branch: 'stable',
          }
        end

        it {
          is_expected.to compile.with_all_deps
        }

        case facts[:os][:family]
        when 'Debian'
          it {
            is_expected.to contain_apt__source('https://nginx.org/packages/mainline/ubuntu/').with(
              ensure: 'present',
            )
          }
        end

        case facts[:os][:family]
        when 'RedHat'
          it {
            is_expected.to contain_file('/etc/yum.repos.d/nginx.repo').with(
              ensure: 'file',
              path: '/etc/yum.repos.d/nginx.repo',
            )
          }
        end
      end

      describe 'nginx::install' do
        let(:params) do
          {
            package_ensure: 'present',
            package_name: 'nginx',
            package_manage: true,
          }
        end

        it {
          is_expected.to contain_package('nginx').with(
            ensure: 'present',
          )
        }

        describe 'should allow package ensure to be overridden' do
          let(:params) do
            {
              package_ensure: 'latest',
              package_name: 'nginx',
              package_manage: true,
            }
          end

          it {
            is_expected.to contain_package('nginx').with_ensure('latest')
          }
        end

        describe 'should allow the package name to be overridden' do
          let(:params) do
            {
              package_ensure: 'present',
              package_name: 'hambaby',
              package_manage: true,
            }
          end

          it {
            is_expected.to contain_package('hambaby')
          }
        end

        describe 'should allow the package to be unmanaged' do
          let(:params) do
            {
              package_manage: false,
              package_name: 'nginx',
            }
          end

          it {
            is_expected.not_to contain_package('nginx')
          }
        end
      end

      describe 'nginx::config' do
        describe 'should provide default install location' do
          it {
            is_expected.to contain_file('/etc/nginx/sites-enabled').with(
              ensure: 'directory',
              purge: false,
              recurse: true,
            )
          }

          it {
            is_expected.to contain_file('/etc/nginx/certs').with(
              ensure: 'directory',
              mode: '0600',
              owner: 'root',
              group: 'root',
            )
          }
        end

        describe 'should allow install location to be overridden' do
          let(:params) do
            {
              install_location: '/opt/nginx-server',
            }
          end

          it {
            is_expected.to contain_file('/opt/nginx-server/sites-enabled').with(
              ensure: 'directory',
              purge: false,
              recurse: true,
            )
          }

          it {
            is_expected.to contain_file('/opt/nginx-server/certs').with(
              ensure: 'directory',
              mode: '0600',
              owner: 'root',
              group: 'root',
            )
          }
        end
      end

      describe 'nginx::service' do
        describe 'should provide default service params' do
          it {
            is_expected.to contain_service('nginx').with(
              ensure: 'running',
              enable: true,
              name: 'nginx',
            )
          }
        end

        describe 'should allow service params to be overridden' do
          let(:params) do
            {
              service_name: 'nginx-service',
              service_ensure: 'stopped',
              service_enable: false,
            }
          end

          it {
            is_expected.to contain_service('nginx-service').with(
              ensure: 'stopped',
              enable: false,
              name: 'nginx-service',
            )
          }
        end

        describe 'should allow the service to be unmanaged' do
          let(:params) do
            {
              service_manage: false,
            }
          end

          it {
            is_expected.not_to contain_service('nginx')
          }
        end
      end
    end
  end
end
