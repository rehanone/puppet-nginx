require 'spec_helper'
describe 'nginx::params', :type => :class do

  let(:facts) { {
    :os => { 'name'    => 'Ubuntu' }
  } }

  it "Should not contain any resources" do
    expect(subject.call.resources.size).to eq(4)
  end
end
