require 'spec_helper'

describe file('/etc/prosody/conf.avail/localhost.cfg.lua') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should eq '644' }

  its('content') do
    should contain(
      'VirtualHost "auth.localhost"').before(
        'authentication = "internal_plain"')
  end
end
