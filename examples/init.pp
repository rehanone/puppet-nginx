node default {
  notify { 'enduser-before': }
  notify { 'enduser-after': }

  class { 'nginx':
    repo_manage => true,

    require     => Notify['enduser-before'],
    before      => Notify['enduser-after'],
  }
}
