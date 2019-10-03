# Puppetsagent calss.
#
# This is a class to install and manage PuppetAgent:
#
# @example Declaring the class
#   include puppetagent
#
# @param [String] agent_certname Certificate name for the agent
# @param [String] agent_version Package version for puppet-agent
# @param [String] agent_environment Set the environment for puppet-agent
# @param [Integer] agent_runinterval Set the interval between agent runs
# @param [String] agent_server Set the puppet server for the agent

class puppetagent(
  String  $agent_certname,
  String  $agent_version,
  String  $agent_environment,
  Integer $agent_runinterval,
  Integer $agent_splaylimit,
  Boolean $agent_splay,
  String  $agent_server,
  ) {

  include puppetagent::install
  include puppetagent::config
  include puppetagent::service

  Class['puppetagent::install']
  -> Class['puppetagent::config']
    -> Class['puppetagent::service']

}
