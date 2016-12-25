
class nginx::service inherits nginx {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $nginx::service_manage {
    service { $nginx::service_name:
      ensure    => $nginx::service_ensure,
      enable    => $nginx::service_enable,
      name      => $nginx::service_name,
      subscribe => Class["${module_name}::config"],
    }
  }
}
