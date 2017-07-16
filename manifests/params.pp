# == Class nginx::params
#
# This class is meant to be called from nginx
# It sets variables according to platform
#
class nginx::params {
  $repo_manage      = true
  $repo_ensure      = present
  $repo_branch      = 'stable'
  $repo_sources     = $::facts[operatingsystem] ? {
    'Ubuntu' => {
      'stable'   => 'ppa:nginx/stable',
      'mainline' => 'ppa:nginx/development',
    },
    'RedHat' => {
      'stable'   => 'http://nginx.org/packages/rhel',
      'mainline' => 'http://nginx.org/packages/mainline/rhel',
    },
    'CentOS' => {
      'stable'   => 'http://nginx.org/packages/centos',
      'mainline' => 'http://nginx.org/packages/mainline/centos',
    },
    'Scientific' => {
      'stable'   => 'http://nginx.org/packages/centos',
      'mainline' => 'http://nginx.org/packages/mainline/centos',
    },
    default => {
      'stable'   => '',
      'mainline' => '',
    },
  }
  $package_manage   = true
  $package_ensure   = 'latest'
  $package_name     = 'nginx'
  $package_extras   = []
  $service_enable   = true
  $service_ensure   = 'running'
  $service_manage   = true
  $service_name     = 'nginx'
  $install_location = '/etc/nginx'
  $service_ports    = {
    '80'  => 'tcp',
    '443' => 'tcp',
  }
  $firewall_manage      = false
  $enabled_sites_manage = false
}
