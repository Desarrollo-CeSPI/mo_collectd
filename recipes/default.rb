node.set['collectd']['fqdn_lookup'] = true
include_recipe 'collectd-lib::packages'
include_recipe 'collectd-lib::directories'
include_recipe 'collectd-lib::config'
include_recipe 'collectd-lib::service'

include_recipe 'mo_collectd::plugins'
