# Main class
## Parameters
### certname: Certificate name for the server and agent
### version: package version for puppetserver

class puppetagent(
  String $agent_certname,
  String $agent_version,
  String $agent_environment,
  String $agent_runinterval,
  String $agent_server,
  ) {

  include puppetagent::install
  include puppetagent::config
  include puppetagent::service

  Class['puppetagent::install']
  -> Class['puppetagent::config']
    -> Class['puppetagent::service']

}
