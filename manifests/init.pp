
class nginx (
  Boolean $repo_manage          = $nginx::params::repo_manage,
  String  $repo_ensure          = $nginx::params::repo_ensure,
  Enum[stable, mainline]
          $repo_branch          = $nginx::params::repo_branch,
  Boolean $package_manage       = $nginx::params::package_manage,
  String  $package_ensure       = $nginx::params::package_ensure,
  String  $package_name         = $nginx::params::package_name,
  Array[String]
          $package_extras       = $nginx::params::package_extras,
  Boolean $service_enable       = $nginx::params::service_enable,
  String  $service_ensure       = $nginx::params::service_ensure,
  Boolean $service_manage       = $nginx::params::service_manage,
  String  $service_name         = $nginx::params::service_name,
  Hash    $service_ports        = $nginx::params::service_ports,
  String  $install_location     = $nginx::params::install_location,
  Boolean $firewall_manage      = $nginx::params::firewall_manage,
  Boolean $enabled_sites_manage = $nginx::params::enabled_sites_manage,
  Hash    $configs              = lookup('nginx::configs', Hash, 'hash', {}),
  Hash    $vhosts               = lookup('nginx::vhosts', Hash, 'hash', {}),
) inherits nginx::params {

  anchor { "${module_name}::begin": }
  -> class { "${module_name}::repo": }
  -> class { "${module_name}::install": }
  -> class { "${module_name}::config": }
  ~> class { "${module_name}::service": }
  -> class { "${module_name}::firewall": }
  -> anchor { "${module_name}::end": }
}
