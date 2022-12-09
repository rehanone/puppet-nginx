define nginx::resource::config (
  String  $source,
  Enum[present, absent] $ensure = present,
) {
  $install_location = $nginx::install_location

  file { "${install_location}/conf.d/${name}.conf":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => $source,
    require => Class["${module_name}::install"],
    notify  => Class["${module_name}::service"],
  }
}
