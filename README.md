[![Build Status](https://travis-ci.org/gutocarvalho/puppet-puppetagent.svg?branch=master)](https://travis-ci.org/gutocarvalho/puppet-puppetagent) ![License](https://img.shields.io/badge/license-Apache%202-blue.svg) [![GitHub version](https://badge.fury.io/gh/gutocarvalho%2Fpuppet-puppetserver.svg)](https://badge.fury.io/gh/gutocarvalho%2Fpuppet-puppetserver)

## Puppetagent Module

This module will install puppet-agent in your system.

This is a very simple module, for development and test purposes.

## Requirements

This module was developed using

- Puppet 4.10
- Hiera 5
- CentOS 7
- Vagrant 1.9
  - box: gutocarvalho/centos7x64

### Hiera 5

Upgrade your /etc/puppetlabs/puppet/hiera.yaml to Hiera v5, see the example bellow:

```
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: "Per-node data (yaml version)"
    path: "nodes/%{trusted.certname}.yaml" # Add file extension.
    # Omitting datadir and data_hash to use defaults.

  - name: "Other YAML hierarchy levels"
    paths: # Can specify an array of paths instead of one.
      - "location/%{facts.whereami}/%{facts.group}.yaml"
      - "groups/%{facts.group}.yaml"
      - "os/%{facts.os.family}.yaml"
      - "common.yaml"
```

After that, you can use this module without problems.

## How to use it

### Installation

via git

    cd /etc/puppetlabs/code/environment/production/modules
    git clone https://github.com/gutocarvalho/puppet-puppetagent.git puppetagent

via puppet

    puppet module install gutocarvalho/puppetagent

### How to use (the fast way)

    puppet apply -e "include puppetagent"

### How to use with parameters

```
class { 'puppetagent':
  agent_certname    => $trusted[certname],
  agent_version     => '1.10.1-1.el7',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => '3600'
}
```
### Classes

```
puppetagent
puppetagent::install (private)
puppetagent::config (private)
puppetagent::service (private)
```

### Hiera Keys (Sample)

```
puppetagent::agent_certname: "%{trusted.certname}"
puppetagent::agent_version: '1.10.1-1.el7'
puppetagent::agent_server: 'puppetserver.hacklab'
puppetagent::agent_environment: 'production'
puppetagent::agent_runinterval: '3600'
```
