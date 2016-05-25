# rehan-nginx

[![Build Status](https://travis-ci.org/rehanone/puppet-nginx.svg?branch=master)](https://travis-ci.org/rehanone/puppet-nginx)

#### Table of Contents
1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
    * [Classes](#classes)
    * [Referances](#referances)
5. [Dependencies](#dependencies)
6. [Development](#development)

## Overview
A Puppet module to install, configure and deploy the latest Nginx webserver from stable or mainline (development) branch.

## Module Description
A puppet module for managing the installation and configuration of Nginx. This module installs and configures the nginx 
package and allows configuration of vhosts and the webproxy itself. The main objective of this module is to minimize 
changes to the default install of nginx package. It tries to give you maximum flexibility by providing `vhost` resource
that can be used to provide a complete file.

Where possible, this module can be used to ensure the nginx installation is up to date with latest upstream release 
branches of nginx. Currently, this feature is supported for the following OSes:

  - Ubuntu (using [ppa:git-core/ppa](https://launchpad.net/~git-core/+archive/ubuntu/ppa "ppa:git-core/ppa") )

## Setup
In order to install `rehan-nginx`, run the following command:
```bash
$ sudo puppet module install rehan-nginx
```
The module does expect all the data to be provided through 'Hiera'. See [Usage](#usage) for examples on how to configure it.

#### Requirements
This module is designed to be as clean and compliant with latest puppet code guidelines. It works with:

  - `puppet >=4.0.0`

## Usage

### Classes

#### `nginx`

A basic install with the defaults would be:
```puppet
include nginx
```

Or the PKI Server using the parameters:
```puppet
class{ 'nginx':
nginx::repo_manage          => true,
nginx::repo_branch          => 'stable',
nginx::package_ensure       => 'latest',
nginx::package_name         => 'nginx',
nginx::package_extras       => [],
nginx::service_manage       => true,
nginx::service_enable       => true,
nginx::service_ensure       => 'running',
nginx::service_name         => 'nginx',
nginx::install_location     => '/etc/nginx',
nginx::firewall_manage      => false,
nginx::enabled_sites_manage => false,
nginx::configs              => hiera_hash('nginx::configs', {}),
nginx::vhosts               => hiera_hash('nginx::vhosts', {}),
}
```

##### Parameters

* **repo_manage**: Manage the upstream repository on supported OSes. The default value is `true`.
* **repo_branch**: The upstream repo branch can be `stable` or `mainline`. The deafult value is `stable`.
* **package_ensure**: Ensure the nginx package is installed. The default value is `latest`.
* **package_name**: Nginx package name. The default is `nginx`.
* **package_extras**: Any extra packages required along with nginx. The default is an empty array.
* **service_enable**: Enables the nginx service at boot. The default is `true`.
* **service_ensure**: Controls the nginx service. The default is `running`.
* **service_manage**: Controls if this module should manage the nginx service. The default is `true`.
* **service_name**: Nginx service name. The default is `nginx`.
* **install_location**: The install location for nginx. The default is `/etc/nginx`.
* **firewall_manage**: Manage the firewall for port `80` and `443` if `puppetlabs-firewall` module is used. The default is `false`.
* **enabled_sites_manage**: If set to true, the `/etc/nginx/sites-enabled` will be purged and only managed vhosts will be maintained.
* **configs**: The hash value for config files that will be dropped in `/etc/nginx/conf.d`. See `nginx::resource::config` for details.
* **vhosts**: The hash value for virtual hosts files to  be dropped in `/etc/nginx/sites-available`. See `nginx::resource::vhost` for details.


All of this data can be provided through `Hiera`. 


**YAML**
```yaml
---
nginx::repo_manage: true
nginx::repo_branch: 'stable'
nginx::package_ensure: 'latest'
nginx::package_name: 'nginx'
nginx::service_manage: true
nginx::service_enable: true
nginx::service_ensure: 'running'
nginx::service_name: 'nginx'
nginx::install_location: '/etc/nginx'
nginx::firewall_manage: false
nginx::enabled_sites_manage: false
nginx::configs:
  logstash_format:
    source: 'puppet:///modules/webproxy/logstash_format.conf'
nginx::vhosts:
  'example.com':
    enabled: true
    source: 'puppet:///modules/webproxy/example.com'
```

**Note:** The above config assumes that you have a module called webproxy with a files directoy containing the static files.

### Resources

#### `nginx::resource::config`

This resource allows creation of a configuration file under `/etc/nginx/conf.d`.

Usage:
```puppet
nginx::resource::config { 'logstash_format':
  source => 'puppet:///modules/webproxy/logstash_format.conf',
}
```

##### Parameters

* **source** a file in a puppet module.

#### `nginx::resource::vhost`

This resource allows creation of a virtual host file under `/etc/nginx/sites-available`.

Usage:
```puppet
nginx::resource::vhost { 'example.com':
  enabled => true
  source  => 'puppet:///modules/webproxy/example.com',
}
```

##### Parameters

* **source** a file in a puppet module.
* **enabled** Creates a link under `/etc/nginx/sites-enabled`.

## Dependencies

* [stdlib][1]
* [apt][2]

[1]:https://forge.puppet.com/puppetlabs/stdlib
[2]:https://forge.puppet.com/puppetlabs/apt

## Development

You can submit pull requests and create issues through the official page of this module: https://github.com/rehan/puppet-nginx.
Please do report any bug and suggest new features/improvements.
