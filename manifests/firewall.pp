class nginx::firewall () inherits nginx {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $nginx::firewall_manage {
    $nginx::service_ports.each |$port, $proto| {
      if defined('::firewall') {
        firewall { "${port} - NGINX - Allow inbound ${proto} connection on port: ${port}":
          dport  => $port,
          proto  => $proto,
          action => accept,
        }
      }

      if defined('::ferm') {
        ferm::rule { "NGINX - Allow inbound ${proto} connection on port: ${port}":
          chain  => 'INPUT',
          proto  => $proto,
          dport  => "(${port})",
          action => 'ACCEPT',
        }
      }
    }
  }
}
