package 'libyajl1'

types_db = ::File.join node['collectd']['extra_conf_dir'], 'fpm-types.db'

file types_db do
  content node['mo_collectd']['fpm']['types_db']
end

file ::File.join node['collectd']['extra_conf_dir'], 'fpm-base.conf' do
  content "TypesDB \"#{types_db}\"\n"
end
