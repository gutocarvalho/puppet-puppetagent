[![Build Status](https://travis-ci.org/gutocarvalho/puppet-puppetagent.svg?branch=master)](https://travis-ci.org/gutocarvalho/puppet-puppetagent) ![License](https://img.shields.io/badge/license-Apache%202-blue.svg) ![Version](https://img.shields.io/puppetforge/v/gutocarvalho/puppetserver.svg) ![Downloads](https://img.shields.io/puppetforge/dt/gutocarvalho/puppetserver.svg)

# Puppetagent

#### Table of contents

1. [Overview](#overview)
3. [Supported Platforms](#supported-platforms)
4. [Requirements](#requirements)
5. [Installation](#installation)
6. [Usage](#usage)
7. [References](#references)
8. [Development](#development)

## Overview

This module will manage puppet-agent in your system.

This is a very simple module, usually used for development and test purposes.

Yes, you can use it in production, but it is a simple module, you may miss some parameters for production use.

The main objective is to manage puppet-agent with minimal intervention in the default files.

Augeas resource type is used to change parameters inside the puppet.conf.

## Supported Platforms

This module was tested under these platforms

- CentOS 6 and 7
- Debian 7 and 8
- Ubuntu 14.04 and 16.04

Tested only in X86_64 arch.  

## Requirements

### Pre-Reqs

You need internet to install packages.

You should configure your hostname properly.

You should configure your /etc/hosts properly.

    ip fqdn alias puppet

### Requirements

- Puppet >= 4.10
- Hiera >= 5

Unfortunately I intent to use Hiera v5 from start, so, yes, Hiera v3 is not compatible with this module.

#### Upgrade your Puppet Agent

Upgrade your puppet agent to >= 4.10, this is necessary to use Hiera v5 features.

RedHat Family

    # yum install puppet-agent

Debian Family

    # apt-get update
    # apt-get install puppet-agent

You need the PC1 repo configured to install puppet-agent.

#### Upgrade your Hiera config

You need to upgrade your hiera config, even with Puppet >= 4.10.

    /etc/puppetlabs/puppet/hiera.yaml

See the example bellow and upgrade your hiera config.

```
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: "Per-node data (yaml version)"
    path: "nodes/%{trusted.certname}.yaml" # Add file extension.

  - name: "Other YAML hierarchy levels"
    paths:
      - "os/%{facts.os.family}.yaml"
      - "common.yaml"
```

After that, you can use this module without problems.

## Installation

via git

    # cd /etc/puppetlabs/code/environment/production/modules
    # git clone https://github.com/gutocarvalho/puppet-agent.git puppetagent

via puppet

    # puppet module install gutocarvalho/puppetagent

via puppetfile

    mod 'gutocarvalho-puppetagent'

## Usage

### Quick run

    puppet apply -e "include puppetagent"

### Using with parameters

#### Example in EL 7

```
class { 'puppetagent':
  agent_certname    => $trusted[certname],
  agent_version     => '1.10.3-1.el7',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

#### Example in EL 6

```
class { 'puppetagent':
  agent_certname    => $trusted[certname],
  agent_version     => '1.10.3-1.el6',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

#### Example in Ubuntu 14.04

```
class { 'puppetagent':
  agent_certname    => $trusted[certname],
  agent_version     => '1.10.3-1trusty',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

#### Example in Ubuntu 16.04

```
class { 'puppetagent':
  agent_certname    => $trusted[certname],
  agent_version     => '1.10.3-1xenial',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

#### Example in Debian 7

```
class { 'puppetagent':
  agent_certname    => $trusted[certname],
  agent_version     => '1.10.3-1wheezy',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

#### Example in Debian 8

```
class { 'puppetagent':
  agent_certname    => $trusted[certname],
  agent_version     => '1.10.3-1jessie',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

## References

### Classes

```
puppetagent
puppetagent::install (private)
puppetagent::config (private)
puppetagent::service (private)
```

### Parameters type

#### `agent_certname`

Type: String

#### `agent_version`

Type: String

#### `agent_server`

Type: String

#### `agent_environment`

Type: String

#### `agent_runinterval`

Type: Integer


### Hiera Keys Sample

```
puppetagent::agent_certname: "%{trusted.certname}"
puppetagent::agent_version: '1.10.3-1.el7'
puppetagent::agent_server: 'puppetserver.hacklab'
puppetagent::agent_environment: 'production'
puppetagent::agent_runinterval: 3600
```

### Hiera module config

This is the Hiera v5 configuration inside the module.

This module does not have params class, everything is under hiera v5.

```
---
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: "OSes"
    paths:
     - "oses/distro/%{facts.os.name}/%{facts.os.release.major}.yaml"
     - "oses/family/%{facts.os.family}.yaml"

  - name: "common"
    path: "common.yaml"

```

This is an example of files under modules/puppetserver/data

```
oses/family/RedHat.yaml
oses/family/Debian.yaml
oses/distro/CentOS/7.yaml
oses/distro/CentOS/8.yaml
oses/distro/Ubuntu/14.04.yaml
oses/distro/Ubuntu/16.04.yaml
oses/distro/Debian/7.yaml
oses/distro/Debian/8.yaml
```

## Development

### My dev environment

This module was developed using

- Puppet 4.10
- Hiera v5
- CentOS 7
- Vagrant 1.9
  - box: gutocarvalho/centos7x64

### Testing

This module uses puppet-lint, puppet-syntax, metadata-json-lint, rspec-puppet, beaker and travis-ci. We hope you use them before submitting your PR.

#### Installing gems

    gem install bundler --no-rdoc --no-ri
    bundle install --without development

#### Running syntax tests

    bundle exec rake syntax
    bundle exec rake lint
    bundle exec rake metadata_lint

#### Running unit tests

    bundle exec rake spec

#### Running acceptance tests

Acceptance tests (Beaker) can be executed using ./acceptance.sh. There is a matrix 1/6 to test this class under Centos 6/7, Debian 7/8 and Ubuntu 14.04/16.04.

If you want a detailed output, set this before run acceptance.sh

    export BEAKER_debug=true

If you want to test a specific OS from our matrix

    BEAKER_set=centos-5-x64 bundle exec rake beaker

Our matrix values

    centos-5-x64
    centos-6-x64
    centos-7-x64
    debian-7-x64
    debian-8-x64
    ubuntu-1404-x64
    ubuntu-1604-x64

This matrix needs vagrant (>=1.9) and virtualbox (>=5.1) to work properly, make sure that you have both of them installed.

### Author/Contributors

Guto Carvalho (gutocarvalho at gmail dot com)
