# docs
class puppetagent::config {

  augeas {'agent_certname':
    context => '/files/etc/puppetlabs/puppet/puppet.conf',
    changes => [ "set main/certname ${puppetagent::agent_certname}", ],
  }

  augeas {'agent_server':
    context => '/files/etc/puppetlabs/puppet/puppet.conf',
    changes => [ "set main/server ${puppetagent::agent_server}", ],
  }

  augeas {'agent_environment':
    context => '/files/etc/puppetlabs/puppet/puppet.conf',
    changes => [ "set main/environment ${puppetagent::agent_environment}", ],
  }

  augeas {'agent_runinterval':
    context => '/files/etc/puppetlabs/puppet/puppet.conf',
    changes => [ "set main/runinterval ${puppetagent::agent_runinterval}", ],
  }

}
