require 'spec_helper'

ssl_keypairs = [
  { 'key' => '/var/lib/prosody/localhost.key',
    'cert' => '/var/lib/prosody/localhost.crt' }
]
ssl_keypairs.each do |ssl_keypair|
  describe x509_certificate(ssl_keypair['cert']) do
    it { should be_certificate }
    it { should be_valid }
    its(:keylength) { should be >= 2048 }
    its(:validity_in_days) { should be >= 30 }
    its(:validity_in_days) { should_not be < 30 }
  end

  describe x509_private_key(ssl_keypair['key']) do
    it { should_not be_encrypted }
    it { should be_valid }
    it { should have_matching_certificate ssl_keypair['cert'] }
  end
end
