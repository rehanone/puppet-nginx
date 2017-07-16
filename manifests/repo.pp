class nginx::repo () inherits nginx {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  if $nginx::repo_manage {

    case $::facts[operatingsystem] {
      'Ubuntu': {
        require apt
        case $nginx::repo_branch {
          'mainline': {
            apt::ppa { $nginx::repo_sources[mainline]:
              ensure => $nginx::repo_ensure,
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
              ensure => $nginx::repo_ensure,
            }
          }
        }
      }
      'RedHat', 'CentOS', 'Scientific': {
        $channelurl = $nginx::repo_sources[$nginx::repo_branch]
        $releasever = $::facts[operatingsystemmajrelease]
        $basearch = $::facts[os][architecture]

        $baseurl = "${channelurl}/${releasever}/${basearch}/"

        file { '/etc/yum.repos.d/nginx.repo':
          ensure  => file,
          path    => '/etc/yum.repos.d/nginx.repo',
          content => template("${module_name}/nginx.repo.erb"),
        }
      }
      'Archlinux': {}
      default: {}
    }
  }
}
