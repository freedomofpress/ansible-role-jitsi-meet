require 'spec_helper'

ufw_expected_rules = [
  %r{ 22/tcp + ALLOW IN +Anywhere},
  %r{ 80/tcp + ALLOW IN +Anywhere},
  %r{ 443/tcp + ALLOW IN +Anywhere},
  %r{ 4443/tcp + ALLOW IN +Anywhere},
  %r{ 10000/udp + ALLOW IN +Anywhere}
]

describe command('ufw status numbered') do
  its(:stdout) { should match(/^Status: active/) }
  ufw_expected_rules.each do |ufw_expected_rule|
    its(:stdout) { should match(ufw_expected_rule) }
  end
end

describe service('ufw') do
  it { should be_enabled }
  # Debian 8 uses systemctl, but not for ufw, oddly.
  it { should be_running } unless os[:family] == 'debian' && os[:release] >= '8'
end
