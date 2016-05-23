# == Class nginx::params
#
# This class is meant to be called from nginx
# It sets variables according to platform
#
class nginx::params {
  $repo_manage      = true
  $repo_branch      = 'stable'
  $repo_sources     = {
    'stable'   => 'ppa:nginx/stable',
    'mainline' => 'ppa:nginx/development',
  }
  $package_ensure   = 'latest'
  $package_name     = 'nginx'
  $service_enable   = true
  $service_ensure   = 'running'
  $service_manage   = true
  $service_name     = 'nginx'
  $install_location = $::facts['osfamily'] ? {
    'Debian'    => '/etc/nginx',
    'Ubuntu'    => '/etc/nginx',
    'Archlinux' => '/etc/nginx',
    default     => '/etc/nginx',
  }
  $service_ports    = {
    '80'  => 'tcp',
    '443' => 'tcp',
  }
  $firewall_manage      = false
  $enabled_sites_manage = false
}
