
class nginx::install {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if ! ($nginx::package_ensure in [ 'absent', 'held', 'installed', 'latest', 'present', 'purged' ]) {
    fail('package_ensure parameter must be one of absent, held, installed, latest, present, purged')
  }

  package { $nginx::package_name:
    ensure => $nginx::package_ensure,
    alias  => 'nginx',
  }
}
