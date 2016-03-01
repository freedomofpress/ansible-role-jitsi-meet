require 'spec_helper'

describe package('nginx') do
  it { should be_installed }
  its('version') { should >= '1.6.2-5' }
end

describe file('/etc/nginx/sites-available/localhost.conf') do
  it { should be_file }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should eq '644' }

  ssl_regexes = [
    %r{^\s+ssl_certificate /var/lib/prosody/localhost.crt;$},
    %r{^\s+ssl_certificate_key /var/lib/prosody/localhost.key;$}
  ]
  ssl_regexes.each do |ssl_regex|
    its('content') { should match(ssl_regex) }
  end
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

nginx_ports = %w(80 443)
nginx_ports.each do |nginx_port|
  describe port(nginx_port) do
    it { should be_listening }
    it { should be_listening.on('0.0.0.0').with('tcp') }
    it { should_not be_listening.on('127.0.0.1') }
  end
end

# Check that nginx process is running as nginx user
describe command('pgrep -u www-data | wc -l') do
  # The default jitsi-meet config sets 4 workers
  its('stdout') { should eq "4\n" }
end

describe command('sudo netstat -nlt') do
  its('stdout') { should_not match(/127\.0\.0\.1:80/) }
  its('stdout') { should_not match(/127\.0\.0\.1:443/) }
  its('stdout') { should match(/0\.0\.0\.0:80/) }
  its('stdout') { should match(/0\.0\.0\.0:443/) }
end
