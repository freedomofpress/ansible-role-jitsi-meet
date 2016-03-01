require 'spec_helper'

# This is actually the port for the "jicofo" service; the jitsi-meet manual
# install docs aren't explicit about default ports. FWIW, the config file
# for jvb says that the default port is "5275", but I suspect that's old info.
jvb_service_port = 5347

describe file('/etc/jitsi/videobridge/config') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should eq '644' }
  its('content') { should match(/^JVB_HOSTNAME=localhost$/) }
  its('content') { should match(/^JVB_HOST=$/) }
  its('content') { should match(/^JVB_PORT=#{jvb_service_port}$/) }
  its('content') { should match(/^JVB_SECRET=\w{8,}$/) }
end

describe service('jitsi-videobridge') do
  it { should be_enabled }
  it { should be_running }
end

describe port(jvb_service_port) do
  it { should be_listening }
  it { should be_listening.on('127.0.0.1') }
  it { should_not be_listening.on('0.0.0.0') }
end

# Check that jicofo process is running as jicofo user
describe command('pgrep -u jicofo | wc -l') do
  its('stdout') { should eq "1\n" }
end

describe command('sudo netstat -nlt') do
  its('stdout') { should match(/127\.0\.0\.1:#{jvb_service_port}/) }
  its('stdout') { should_not match(/0\.0\.0\.0:#{jvb_service_port}/) }
end
