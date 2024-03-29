class nginx::config () inherits nginx {
  assert_private("Use of private class ${name} by ${caller_module_name}")

  file { "${nginx::install_location}/nginx.conf":
    ensure  => file,
    content => epp("${module_name}/nginx.conf.epp",
      {
        'install_location' => $nginx::install_location,
      }
    ),
  }
  -> file { "${nginx::install_location}/sites-available":
    ensure  => directory,
    recurse => true,
  }
  -> file { "${nginx::install_location}/sites-enabled":
    ensure  => directory,
    purge   => $nginx::enabled_sites_manage,
    recurse => true,
  }
  -> file { "${nginx::install_location}/certs":
    ensure => directory,
    mode   => '0600',
    owner  => 'root',
    group  => 'root',
  }

  create_resources('nginx::resource::config', $nginx::configs)
  create_resources('nginx::resource::vhost', $nginx::vhosts)
}
