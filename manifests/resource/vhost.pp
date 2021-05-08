define nginx::resource::vhost (
  String  $source                 = '',
  String  $content                = '',
  Enum[ present, absent ] $ensure = present,
  Boolean $enabled                = true,
) {

  if (empty($source)) and (empty($content)) {
    fail('Please provide source or content')
  }
  elsif (!empty($source)) and (!empty($content)) {
    fail('Please provide source or content, the options are mutually exclusive')
  }

  $file_source = $source ? {
    ''      => undef,
    default => $source,
  }

  $file_content = $content ? {
    ''      => undef,
    default => $content,
  }

  $install_location = $nginx::install_location
  $sites_available = "${install_location}/sites-available"
  $sites_enabled = "${install_location}/sites-enabled"

  $ensure_certs_dir = $ensure ? {
    'present' => directory,
    default   => $ensure,
  }

  file { "${install_location}/certs/${name}":
    ensure  => $ensure_certs_dir,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    require => File["${nginx::install_location}/certs"],
  }

  $ensure_sites_available = $ensure ? {
    'present' => file,
    default   => $ensure,
  }

  file { "${sites_available}/${name}":
    ensure  => $ensure_sites_available,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => $file_source,
    content => $file_content,
    require => File[$sites_enabled],
    notify  => Class["${module_name}::service"],
  }

  $ensure_sites_enabled = $enabled ? {
    false   => absent,
    default => link,
  }

  if $ensure == 'present' {
    file { "${sites_enabled}/${name}":
      ensure  => $ensure_sites_enabled,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      target  => "${sites_available}/${name}",
      require => File["${sites_available}/${name}"],
      notify  => Class["${module_name}::service"],
    }
  }
}
