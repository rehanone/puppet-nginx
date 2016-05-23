# Class: nginx::service
#
# This module manages NGINX service management and vhost rebuild
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class nginx::service inherits nginx {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if ! ($nginx::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $nginx::service_manage {
    service { $nginx::service_name:
      ensure     => $nginx::service_ensure,
      enable     => $nginx::service_enable,
      name       => $nginx::service_name,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => Class["${module_name}::config"],
    }
  }
}
