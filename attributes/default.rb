default['mo_collectd']['process'] = Hash.new

default['mo_collectd']['df'] = '/'

default['mo_collectd']['ntpd']['host'] = 'localhost'
default['mo_collectd']['ntpd']['port'] = 123

default['mo_collectd']['interface'] = node.network.default_interface

default['mo_collectd']['graphite']['host'] = '127.0.0.1'
default['mo_collectd']['graphite']['port'] = 2003
default['mo_collectd']['graphite']['protocol'] = 'udp'

default['mo_collectd']['mysql']['host'] = node.fqdn
default['mo_collectd']['mysql']['username'] = 'collectd'
default['mo_collectd']['mysql']['password'] = 'collectdpass'
default['mo_collectd']['mysql']['port'] = '3306'
default['mo_collectd']['mysql']['superuser'] = 'root'
default['mo_collectd']['mysql']['superuser_password'] = nil

default['mo_collectd']['nginx']['status_url'] = "http://localhost:8090/nginx_status"

