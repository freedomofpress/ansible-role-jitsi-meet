require 'spec_helper'

describe package('jitsi-meet') do
  it { should be_installed }
end

describe package('default-jre-headless') do
  it { should be_installed }
end

describe command('echo "get jitsi-meet/jvb-hostname" | \
                  debconf-communicate') do
  its('stdout') { should eq "0 localhost\n" }
end

describe command('echo "get jitsi-meet/jvb-serve" | \
                  debconf-communicate') do
  its('stdout') { should eq "0 false\n" }
end

describe command('echo "get jitsi-meet-prosody/jvb-hostname" | \
                  debconf-communicate') do
  its('stdout') { should eq "0 localhost\n" }
end
