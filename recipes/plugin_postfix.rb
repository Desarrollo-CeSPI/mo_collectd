include_recipe 'collectd-lib::config'

filename = 'postfix-types.db'
types_db = ::File.join node['collectd']['conf_dir'], filename

cookbook_file filename do
  path types_db
end

template "#{node['collectd']['extra_conf_dir']}/postfix-tail.conf" do
  source "postfix-tail.conf.erb"
  variables(types_db: types_db)
  action :create
end
