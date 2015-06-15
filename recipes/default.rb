include_recipe "chef-sugar"


if ubuntu_before_or_at_precise?
  apt_repository 'collectd' do
    uri          'ppa:rullmann/collectd'
    distribution node['lsb']['codename']
  end
end

node.set['collectd']['fqdn_lookup'] = true
include_recipe 'collectd-lib::packages'
include_recipe 'collectd-lib::directories'
include_recipe 'collectd-lib::config'
include_recipe 'collectd-lib::service'

include_recipe 'mo_collectd::plugins'
include_recipe 'mo_collectd::helpers'
