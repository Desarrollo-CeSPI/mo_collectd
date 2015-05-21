mysql2_chef_gem 'default' do
  action :install
end

collectd_conf 'mysql' do
  plugin 'mysql'
  conf %w(Database main) => {
    'Host'      => node['mo_collectd']['mysql']['host'],
    'User'      => node['mo_collectd']['mysql']['username'],
    'Password'  => node['mo_collectd']['mysql']['password'],
    'Port'      => node['mo_collectd']['mysql']['port']
  }.merge(
    node.tags.include?('mysql_master') ? { 'MasterStats' => true } :
      (node.tags.include?('mysql_slave') ? { 'SlaveStats' => true, 'SlaveNotifications' => true } : {} )
    )
end

db_connection = {host: node['mo_collectd']['mysql']['host'], 
                 username: node['mo_collectd']['mysql']['superuser'], 
                 password: node['mo_collectd']['mysql']['superuser_password'] || node['mysql']['server_root_password']
                }

mysql_database_user node['mo_collectd']['mysql']['username'] do
  connection db_connection
  username node['mo_collectd']['mysql']['username']
  password node['mo_collectd']['mysql']['password']
  host node['mo_collectd']['mysql']['host']
  privileges ['USAGE', 'REPLICATION CLIENT']
  action [:create , :grant]
end
