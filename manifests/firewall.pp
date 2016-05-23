class nginx::firewall () inherits nginx {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $nginx::firewall_manage and defined('::firewall') {
    $nginx::service_ports.each |$port, $proto| {
      firewall { "${port} Allow inbound ${proto} connection on port: ${port}":
        dport  => $port,
        proto  => $proto,
        action => accept,
      }
    }
  }
}
