
class nginx::install {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  ensure_packages($nginx::package_extras, { 'ensure' => $nginx::package_ensure })

  if $nginx::package_manage {
    package { $nginx::package_name:
      ensure => $nginx::package_ensure,
    }
  }
}
