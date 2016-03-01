require 'spec_helper'

describe file('/etc/jitsi/jicofo/config') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should eq '644' }
  its('content') { should match(/^JICOFO_HOST=localhost$/) }
  its('content') { should match(/^JICOFO_PORT=5347$/) }
  its('content') { should match(/^JICOFO_SECRET=\w{8,}$/) }
  its('content') { should match(/^JICOFO_AUTH_PASSWORD=\w{8,}$/) }
  its('content') { should match(/^JICOFO_AUTH_USER=focus$/) }
end
