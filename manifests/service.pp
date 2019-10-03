# docs
class puppetagent::service {

  service { 'puppet':
    ensure => $puppetagent::service_ensure,
    enable => $puppetagent::service_enable,
    name   => $puppetagent::service_name,
    }

}
