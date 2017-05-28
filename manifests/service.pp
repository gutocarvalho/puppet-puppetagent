# docs
class puppetagent::service {

  service { 'puppet':
    ensure => 'running',
    enable => true,
  }

}
