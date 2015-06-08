include_recipe 'collectd-lib::config'

filename = 'postfix-types.db'
types_db = ::File.join node['collectd']['conf_dir'], filename

node.set['collectd']['types_db'] = ( node['collectd']['types_db'].to_a + [ types_db ] ).uniq

cookbook_file filename do
  path types_db
end

template "#{node['collectd']['extra_conf_dir']}/postfix-tail.conf" do
  source "postfix-tail.conf.erb"
  action :create
end
