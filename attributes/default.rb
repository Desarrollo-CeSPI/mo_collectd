default['mo_collectd']['process'] = Hash.new

default['mo_collectd']['df'] = '/'

default['mo_collectd']['ntpd']['host'] = 'localhost'
default['mo_collectd']['ntpd']['port'] = 123

default['mo_collectd']['interface'] = node.network.default_interface

default['mo_collectd']['graphite']['host'] = '127.0.0.1'
default['mo_collectd']['graphite']['port'] = 2003
default['mo_collectd']['graphite']['protocol'] = 'udp'

default['mo_collectd']['postfix']['types_db'] = "mail_counter value:COUNTER:0:65535"
default['mo_collectd']['postfix']['log_file'] = "/var/log/mail.log"

default['mo_collectd']['mysql']['host'] = "127.0.0.1"
default['mo_collectd']['mysql']['username'] = 'collectd'
default['mo_collectd']['mysql']['password'] = 'collectdpass'
default['mo_collectd']['mysql']['port'] = '3306'
default['mo_collectd']['mysql']['superuser'] = 'root'
default['mo_collectd']['mysql']['superuser_password'] = nil

default['mo_collectd']['nginx']['status_url'] = "http://localhost:8090/nginx_status"

default['mo_collectd']['fpm']['types_db'] = <<-EOL
# types.db
fpm_http_requests      count:COUNTER:0:134217728
fpm_listen_queue       value:GAUGE:0:65535
fpm_active_processes   value:GAUGE:0:65535
fpm_total_processes    value:GAUGE:0:65535
EOL

default['mo_collectd']['user_rss']['script'] = "/usr/local/bin/mo_collectd_user_rss"
