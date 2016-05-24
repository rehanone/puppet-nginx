class nginx::repo () inherits nginx {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $nginx::repo_manage {
    case $::facts[operatingsystem] {
      'Ubuntu': {
        contain apt
        case $nginx::repo_branch {
          'mainline': {
            apt::ppa { $nginx::repo_sources[mainline]:
              ensure => present,
            }
            apt::ppa { $nginx::repo_sources[stable]:
              ensure => absent,
            }
          }
          default: {
            apt::ppa { $nginx::repo_sources[mainline]:
              ensure => absent,
            }
            apt::ppa { $nginx::repo_sources[stable]:
              ensure => present,
            }
          }
        }
      }
      'Archlinux': {}
      default: {}
    }
  }
}
