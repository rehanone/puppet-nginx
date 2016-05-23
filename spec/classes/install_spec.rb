require 'spec_helper'
describe 'nginx::install', :type => :class do
  let :pre_condition do
      'class { "nginx": }'
  end

  it { is_expected.to contain_package('nginx') }
end
