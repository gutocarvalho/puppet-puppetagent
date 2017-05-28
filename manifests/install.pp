# docs
class puppetagent::install {

  package { 'puppet-agent':
    ensure => $puppetagent::agent_version,
  }

}
