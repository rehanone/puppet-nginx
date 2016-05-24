
class nginx (
  $repo_manage          = $nginx::params::repo_manage,
  $repo_branch          = $nginx::params::repo_branch,
  $package_ensure       = $nginx::params::package_ensure,
  $package_name         = $nginx::params::package_name,
  $package_extras       = $nginx::params::package_extras,
  $service_enable       = $nginx::params::service_enable,
  $service_ensure       = $nginx::params::service_ensure,
  $service_manage       = $nginx::params::service_manage,
  $service_name         = $nginx::params::service_name,
  $service_ports        = $nginx::params::service_ports,
  $install_location     = $nginx::params::install_location,
  $firewall_manage      = $nginx::params::firewall_manage,
  $enabled_sites_manage = $nginx::params::enabled_sites_manage,
) inherits nginx::params {

  validate_bool($repo_manage)
  validate_re($repo_branch, [ '^stable', '^mainline' ], 'repo_branch parameter must be stable or mainline')
  validate_string($package_ensure)
  validate_string($package_name)
  validate_array($package_extras)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_hash($service_ports)
  validate_string($install_location)
  validate_bool($firewall_manage)
  validate_bool($enabled_sites_manage)

  anchor { "${module_name}::begin": } ->
  class {"${module_name}::repo":} ->
  class {"${module_name}::install":} ->
  class {"${module_name}::config":} ~>
  class {"${module_name}::service":} ->
  class {"${module_name}::firewall":} ->
  anchor { "${module_name}::end": }
}
