include_recipe "chef-sugar"


if ubuntu_before_or_at_precise?
  apt_repository 'collectd' do
    uri          'ppa:rullmann/collectd'
    distribution node['lsb']['codename']
  end
end

node.set['collectd']['fqdn_lookup'] = true
if debian_wheezy?
  cookbook_file 'collectd-core_5.4.1-6_amd64.deb' do
    path '/root/collectd-core_5.4.1-6_amd64.deb'
  end

  dpkg_package '/root/collectd-core_5.4.1-6_amd64.deb'
else
  include_recipe 'collectd-lib::packages'
end
include_recipe 'collectd-lib::directories'
include_recipe 'collectd-lib::config'
include_recipe 'collectd-lib::service'

include_recipe 'mo_collectd::plugins'
include_recipe 'mo_collectd::helpers'
