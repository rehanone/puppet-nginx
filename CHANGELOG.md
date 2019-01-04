## 2.1.1 (January 3, 2019)

Improvements:

- Updated `pdk` templates.

## 2.1.0 (October 14, 2018)

Improvements:

- Updated `pdk` templates.
- Added support for `puppet` version 6.

## 2.0.4 (September 1, 2018)

Improvements:

- Updated `pdk` templates.
- Added tests for Debian 9 release.
- Updated `puppetlabs-stdlib` dependency version.
- Fixed minor documentation issues.

## 2.0.3 (May 29, 2018)

Improvements:

- Updated module dependencies.
- Added tests for Ubuntu 18.04 release.
- Updated `pdk` templates.

## 2.0.2 (May 7, 2018)

Improvements:

- Updated `pdk` templates.
- Updated minimum required `puppet` version to `4.10.0`.
- Improved acceptance tests.

## 2.0.1 (April 21, 2018)

Bugfixes:

  - Fix minor documentation errors.

## 2.0.0 (April 20, 2018)

Features:
  - Added `task` for managing nginx service.

Improvements:

  - Updated module to be `pdk` compliant.
  - Updated module data to `hiera 5`.

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

