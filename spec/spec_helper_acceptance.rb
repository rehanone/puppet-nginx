require 'beaker-rspec'
require 'beaker/puppet_install_helper'

UNSUPPORTED_PLATFORMS = ['windows']

unless ENV['RS_PROVISION'] == 'no' or ENV['BEAKER_provision'] == 'no'

  run_puppet_install_helper

  hosts.each do |host|
    environmentpath = host.puppet['environmentpath']
    environmentpath = environmentpath.split(':').first if environmentpath

    on host, puppet('module install puppetlabs-stdlib --version 4.16.0')
    on host, puppet('module install puppetlabs-apt --version 2.3.0')
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    hosts.each do |host|
      apply_manifest_on(host, 'package { "python-software-properties": }')
      apply_manifest_on(host, 'package { "software-properties-common": }')
      copy_module_to(host, :source => proj_root, :module_name => 'nginx')
      shell("/bin/touch #{default['puppetpath']}/hiera.yaml")
    end
  end
end
