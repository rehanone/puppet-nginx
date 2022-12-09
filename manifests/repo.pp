class nginx::repo () inherits nginx {
  assert_private("Use of private class ${name} by ${caller_module_name}")
  $architecture = $::facts[os][architecture]

  if $nginx::repo_manage {
    case $::facts[os][name] {
      'Debian', 'Ubuntu': {
        $key = {
          'id'     => '573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62',
          'server' => 'keyserver.ubuntu.com',
        }

        require apt
        case $nginx::repo_branch {
          'mainline': {
            if $::facts[os][name] == 'Ubuntu' {
              $ppa = 'ppa:nginx/development'
              apt::ppa { $ppa:
                ensure => absent,
              }
            }

            apt::source { "nginx-${nginx::repo_branch}":
              ensure       => $nginx::repo_ensure,
              location     => $nginx::repo_sources[mainline],
              repos        => 'nginx',
              architecture => $architecture,
              key          => $key,
              include      => {
                'src' => true,
                'deb' => true,
              },
            }

            apt::source { "nginx-${nginx::repo_sources[stable]}":
              ensure => absent,
            }
          }
          default: {
            if $::facts[os][name] == 'Ubuntu' {
              $ppa = 'ppa:nginx/stable'
              apt::ppa { $ppa:
                ensure => absent,
              }
            }

            apt::source { "nginx-${nginx::repo_branch}":
              ensure       => $nginx::repo_ensure,
              location     => $nginx::repo_sources[mainline],
              repos        => 'nginx',
              architecture => $architecture,
              key          => $key,
              include      => {
                'src' => true,
                'deb' => true,
              },
            }

            apt::source { "nginx-${nginx::repo_sources[mainline]}":
              ensure => absent,
            }
          }
        }
      }
      'RedHat', 'CentOS', 'Scientific': {
        $channelurl = $nginx::repo_sources[$nginx::repo_branch]
        $releasever = $::facts[os][release][major]

        file { '/etc/yum.repos.d/nginx.repo':
          ensure  => file,
          path    => '/etc/yum.repos.d/nginx.repo',
          content => epp("${module_name}/nginx.repo.epp",
            {
              baseurl => "${channelurl}/${releasever}/${architecture}/",
            }
          ),
        }
      }
      'Archlinux': {}
      default: {}
    }
  }
}
