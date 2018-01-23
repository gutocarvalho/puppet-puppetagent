[![Build Status](https://travis-ci.org/gutocarvalho/puppet-puppetagent.svg?branch=master)](https://travis-ci.org/gutocarvalho/puppet-puppetagent) ![License](https://img.shields.io/badge/license-Apache%202-blue.svg) ![Version](https://img.shields.io/puppetforge/v/gutocarvalho/puppetagent.svg) ![Downloads](https://img.shields.io/puppetforge/dt/gutocarvalho/puppetagent.svg)

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

This module will manage puppet-agent 5.3 in your system.

**If you are looking into puppet 4 please use an older version of this module.**

This is a very simple module, usually used for development and test purposes.

Yes, you can use it in production, but it is a simple module, you may miss some parameters for production use.

The main objective is to manage puppet-agent with minimal intervention in the default files.

Augeas resource type is used to change parameters inside the puppet.conf.

## Supported Platforms

This module was tested under these platforms

- RedHat 5, 6 and 7
- CentOS 5, 6 and 7
- Scientific 6 and 7
- Debian 7, 8 and 9
- Ubuntu 14.04 and 16.04

Tested only in X86_64 arch.  

## Requirements

### Pre-Reqs

You need internet to install packages.

You should configure your hostname properly.

You should configure your /etc/hosts properly.

    ip fqdn alias

### Requirements

- Puppet >= 5.x
  - Hiera >= 3.4
  - Facter >= 2.5

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
  agent_certname    => $trusted['certname'],
  agent_version     => '5.3.3-1.el7',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

#### Example in EL 6

```
class { 'puppetagent':
  agent_certname    => $trusted['certname'],
  agent_version     => '5.3.3-1.el6',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

#### Example in EL 5

```
class { 'puppetagent':
  agent_certname    => $trusted['certname'],
  agent_version     => '5.3.3-1.el5',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

#### Example in Ubuntu 14.04

```
class { 'puppetagent':
  agent_certname    => $trusted['certname'],
  agent_version     => '5.3.3-1trusty',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

#### Example in Ubuntu 16.04

```
class { 'puppetagent':
  agent_certname    => $trusted['certname'],
  agent_version     => '5.3.3-1xenial',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

#### Example in Debian 7

```
class { 'puppetagent':
  agent_certname    => $trusted['certname'],
  agent_version     => '5.3.3-1wheezy',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

#### Example in Debian 8

```
class { 'puppetagent':
  agent_certname    => $trusted['certname'],
  agent_version     => '5.3.3-1jessie',
  agent_server      => 'pupperserver.hacklab',
  agent_environment => 'production',
  agent_runinterval => 3600
}
```

#### Example in Debian 9

```
class { 'puppetagent':
  agent_certname    => $trusted['certname'],
  agent_version     => '5.3.3-1stretch',
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

Certificate name for the agent

#### `agent_version`

Type: String

The puppet agent package version (5.3.0-1xenial|installed|latest)

#### `agent_server`

Type: String

The puppet master server to which the puppet agent should connect.

#### `agent_environment`

Type: String

Set which environment your puppet agent will use.

#### `agent_runinterval`

Type: Integer

Set how often puppet agent applies the catalog in seconds.

### Hiera Keys Sample

```
puppetagent::agent_certname: "%{trusted.certname}"
puppetagent::agent_version: '5.3.3-1.el7'
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
oses/distro/CentOS/5.yaml
oses/distro/CentOS/7.yaml
oses/distro/CentOS/8.yaml
oses/distro/Ubuntu/14.04.yaml
oses/distro/Ubuntu/16.04.yaml
oses/distro/Debian/7.yaml
oses/distro/Debian/8.yaml
oses/distro/Debian/9.yaml
```

## Development

### My dev environment

This module was developed using

- Puppet 5.3.3
  - Hiera 3.4.2 (v5 format)
  - Facter 2.5.1
- CentOS 7
- VirtualBox 5.1.28
- Vagrant 2.0
  - box: gutocarvalho/centos7x64puppet5

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

Acceptance tests (Beaker) can be executed using ./acceptance.sh. There is a matrix 1/8 to test this class under Centos 5/6/7, Debian 7/8/9 and Ubuntu 14.04/16.04.

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
    debian-9-x64
    ubuntu-1404-x64
    ubuntu-1604-x64

This matrix needs vagrant (>=2.0) and virtualbox (>=5.1) to work properly, make sure that you have both of them installed.

### Author/Contributors

Guto Carvalho (gutocarvalho at gmail dot com)
