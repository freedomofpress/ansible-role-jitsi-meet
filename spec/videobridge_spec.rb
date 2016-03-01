require 'spec_helper'

describe file('/etc/jitsi/videobridge/config') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should eq '644' }
  its('content') { should match(/^JVB_HOSTNAME=localhost$/) }
  its('content') { should match(/^JVB_HOST=$/) }
  its('content') { should match(/^JVB_PORT=5275$/) }
  its('content') { should match(/^JVB_SECRET=\w{8,}$/) }
end

describe service('jitsi-videobridge') do
  it { should be_enabled }
  it { should be_running }
end

describe port(5275) do
  it { should be_listening }
  it { should be_listening.on('127.0.0.1') }
  it { should_not be_listening.on('0.0.0.0') }
end

# Check that jicofo process is running as jicofo user
describe command('pgrep -u jicofo | wc -l') do
  its('stdout') { should eq "1\n" }
end

describe command('sudo netstat -nlt') do
  its('stdout') { should match(/127\.0\.0\.1:5275/) }
  its('stdout') { should_not match(/0\.0\.0\.0:5275/) }
end
