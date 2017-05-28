require 'spec_helper'
describe 'puppetagent', :type => :class do
  context 'with defaults for all parameters' do
    let (:facts) do {
      :kernel => 'Linux',
      :osfamily => 'Redhat',
      :operatingsystem => 'CentOS',
      :operatingsystemmajrelease => '7',
    }
    end
  end

  it { is_expected.to compile }
  it { is_expected.to compile.with_all_deps }

  it { is_expected.to contain_class('puppetagent') }
  it { is_expected.to contain_class('puppetagent::install').that_comes_before('Class[puppetagent::config]') }
  it { is_expected.to contain_class('puppetagent::config').that_comes_before('Class[puppetagent::service]') }

  context 'puppetserver::install' do
    it { is_expected.to contain_package('puppet-agent') }
  end

  context 'puppetserver::config' do
    it { is_expected.to contain_augeas('agent_certname').with({
      'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
    })}
    it { is_expected.to contain_augeas('agent_server').with({
      'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
    })}
    it { is_expected.to contain_augeas('agent_runinterval').with({
      'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
    })}
    it { is_expected.to contain_augeas('agent_environment').with({
      'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
    })}
  end

  context 'puppetserver::service' do
      it { is_expected.to contain_service('puppet').with({
        'ensure' => 'running',
        'enable' => true,
        })
      }
    end

end
