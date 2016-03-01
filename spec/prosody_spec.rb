require 'spec_helper'

describe file('/etc/prosody/conf.avail/localhost.cfg.lua') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should eq '644' }

  its('content') do
    should contain(
      'VirtualHost "localhost"').before(
        'authentication = "anonymous"')
  end

  wanted_enabled_modules = %w(bosh pubsub ping)
  wanted_enabled_modules.each do |enabled_module|
    its('content') do
      should contain(
        enabled_module.to_s).from(
          /^\s+modules_enabled = \{/).to(
            /^\s+\}$/)
    end
  end
  its('content') do
    should contain(
      'VirtualHost "auth.localhost"').before(
        'authentication = "internal_plain"')
  end
end
