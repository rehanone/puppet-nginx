class nginx::config () inherits nginx {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  file { "${nginx::install_location}/sites-enabled":
    ensure  => directory,
    purge   => $nginx::enabled_sites_manage,
    recurse => true,
  }
}
