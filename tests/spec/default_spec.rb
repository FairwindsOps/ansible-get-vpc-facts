require 'spec_helper'

describe file('/etc/apt/sources.list.d/apt_newrelic_com_debian.list') do
  it { is_expected.to be_file }
end

describe package 'newrelic-sysmond' do
  it { is_expected.to be_installed }
end

describe file('/etc/newrelic/nrsysmond.cfg') do
  it { should contain '^license_key=0000ffff0000ffff0000ffff0000ffff0000ffff$' }
end
