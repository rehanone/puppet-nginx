
class nginx (
  Boolean $repo_manage,
  String  $repo_ensure,
  Enum[stable, mainline]
          $repo_branch,
  Struct[
    {
      stable => String,
      mainline => String
    }
  ]
          $repo_sources,
  Boolean $package_manage,
  String  $package_ensure,
  String  $package_name,
  Array[String]
          $package_extras,
  Boolean $service_enable,
  String  $service_ensure,
  Boolean $service_manage,
  String  $service_name,
  Hash    $service_ports,
  String  $install_location,
  Boolean $firewall_manage,
  Boolean $enabled_sites_manage,
  Hash    $configs              = lookup('nginx::configs', Hash, 'hash', {}),
  Hash    $vhosts               = lookup('nginx::vhosts', Hash, 'hash', {}),
) {

  anchor { "${module_name}::begin": }
  -> class { "${module_name}::repo": }
  -> class { "${module_name}::install": }
  -> class { "${module_name}::config": }
  ~> class { "${module_name}::service": }
  -> class { "${module_name}::firewall": }
  -> anchor { "${module_name}::end": }
}
