## 1.0.0 (February 17, 2018)

Improvements:

  - Added unit tests to cover all supported OS entries.
  - Added Puppet 5 support.
  - Updated templates from erb to epp.
  - Updated OS support matrix.

## 0.4.0 (July 16, 2017)

Improvements:

  - Added `repo_ensure` parameter.
  - Added `package_manage` parameter.
  - Replace deprecated `hiera_hash` to `lookup`.
  - Update minimum puppet version required is set to `4.7.0`.
  - Updated `puppetlabs-apt` module dependency versions.

Bugfixes:

  - Fix the style issues in chaining arrows.

## 0.3.0 (December 25, 2016)

Features:

  - Add support for RedHad, CentOS and Scientific Linux from version 5 to 7. This includes updates from Official Nginx channel for both stable and mainline builds.
  - Introduce proper Puppet 4 types for parameters.
  - Remove legacy validate statements of puppet-stdlib module.
  - Increased unit and acceptance tests coverage.

## 0.2.0 (July 18, 2016)

Features:

  - Added option to work with templates in the vhost.

## 0.1.0 (May 22, 2016)

Features:

  - Initial release

Bugfixes:

