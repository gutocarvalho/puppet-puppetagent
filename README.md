[![Build Status](https://travis-ci.org/gutocarvalho/puppet-puppetagent.svg?branch=master)](https://travis-ci.org/gutocarvalho/puppet-puppetagent) ![License](https://img.shields.io/badge/license-Apache%202-blue.svg)

### Table of contents

1. Overview
2. Development information
3. OSes Supported
4. PreReq
5. Requirements
6. How to use it

## 1. Overview

This module will manage puppet-agent in your system.

This is a very simple module, usually used for development and test purposes.

Yes, you can use it in production, but it is a simple module, you may miss some parameters for production use.

The main objective is to manage puppet-agent with minimal intervention in the default files.

Augeas resource type is used to change parameters inside the puppet.conf.

## 2. Development information

This module was developed using

- Puppet 4.10.1
- Hiera 5
- CentOS 7
- Vagrant 1.9
  - box: gutocarvalho/centos7x64

## 3. OSes Supported

This module was tested under these Oses

- CentOS 5, 6 and 7
- Debian 7 and 8
- Ubuntu 14.04 and 16.04

Tested only in X86_64 arch.  

## 4. PreReq

You need internet to install packages, or at least a local mirror.

You should configure your hostname properly.

You should configure your /etc/hosts properly.

    ip fqdn alias puppet

## 5. Requirements

- Puppet >= 4.10
- Hiera >= 5

Unfortunately I intent to use Hiera v5 from start, so, yes, Hiera v3 is not compatible with this module.

#### 5.1 Hiera 5

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

## 6. How to use it

Upgrade your puppet agent to >= 4.10, this is necessary to use Hiera v5 features.

    # yum install puppet-agent (redhat family)
    # apt-get update && apt-get install puppet-agent (debian family)

You need PC1 repo configured to install puppet-agent package.

### 6.1 Installation

via git

    cd /etc/puppetlabs/code/environment/production/modules
    git clone https://github.com/gutocarvalho/puppet-puppetagent.git puppetagent

via puppet

    puppet module install gutocarvalho/puppetagent

### 6.2 How to use (the fast way)

    puppet apply -e "include puppetagent"

### 6.3 How to use with parameters

```
class { 'puppetagent':
  agent_certname    => $trusted[certname],
  agent_version     => '1.10.1-1.el7',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => '3600'
}
```
## 7. Classes

```
puppetagent
puppetagent::install (private)
puppetagent::config (private)
puppetagent::service (private)
```

## 8. Hiera Keys (Sample)

```
puppetagent::agent_certname: "%{trusted.certname}"
puppetagent::agent_version: '1.10.1-1.el7'
puppetagent::agent_server: 'puppetserver.hacklab'
puppetagent::agent_environment: 'production'
puppetagent::agent_runinterval: '3600'
```
