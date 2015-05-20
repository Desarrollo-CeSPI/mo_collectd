default['mo_collectd']['process'] = Hash.new
default['mo_collectd']['df'] = '/'
default['mo_collectd']['ntpd']['host'] = 'localhost'
default['mo_collectd']['ntpd']['port'] = 123
default['mo_collectd']['interface'] = node.network.default_interface
default['mo_collectd']['graphite']['host'] = '127.0.0.1'
default['mo_collectd']['graphite']['port'] = 2003
default['mo_collectd']['graphite']['protocol'] = 'udp'

