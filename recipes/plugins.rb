include_recipe "chef-sugar"

collectd_conf 'cpu' do
  plugin 'cpu'
end

collectd_conf 'memory' do
  plugin 'memory'
end

node['mo_collectd']['process'].each do |name, regex|
  collectd_conf "processes #{name}" do
    plugin 'processes'
    conf 'ProcessMatch' => Array(name) + Array(regex)
  end
end

collectd_conf 'df' do
  plugin 'df'
  conf( {
        'MountPoint' => node['mo_collectd']['df']
        }.merge(
          ubuntu_before_or_at_precise? ? {} : {
            'ValuesPercentage' => true
          }))
end

collectd_conf 'load' do
  plugin 'load'
end

collectd_conf 'interface' do
  plugin 'interface'
  conf 'Interface' => node['mo_collectd']['interface']
end

collectd_conf 'swap' do
  plugin 'swap'
end

collectd_conf 'users' do
  plugin 'users'
end

collectd_conf 'uptime' do
  plugin 'uptime'
end

collectd_conf 'tcpconns' do
  plugin 'tcpconns'
  conf 'ListeningPorts' => true
end

collectd_conf 'ntpd' do
  plugin 'ntpd'
  conf  'Host' => node['mo_collectd']['ntpd']['host'],
    'Port' => node['mo_collectd']['ntpd']['port']
end

if ubuntu_before_or_at_precise?

  package "libpython2.7"

  cookbook_file File.join(node[:collectd][:plugin_dir], "carbon_writer.py") do
    owner "root"
    group "root"
    mode "644"
  end

  collectd_conf 'python_carbon_writer' do
    plugin 'python' => {'Globals' => true}
    conf 'ModulePath' => node['collectd']['plugin_dir'],
         'Import' => 'carbon_writer',
         %w(Module carbon_writer) => {
            'LineReceiverHost' => node['mo_collectd']['graphite']['host'],
            'LineReceiverPort' => node['mo_collectd']['graphite']['port'],
            'LineReceiverProtocol' => node['mo_collectd']['graphite']['protocol'],
            'DifferentiateCountersOverTime' => true,
            'MetricPrefix' => "collectd.#{node.chef_environment}.",
            'TypesDB' => node['collectd']['types_db']
         }
  end
else
  collectd_conf 'write_graphite' do
    plugin 'write_graphite'
    conf %w(Node graphite) => {
           'Host' => node['mo_collectd']['graphite']['host'],
           'Port' => node['mo_collectd']['graphite']['port'],
           'Protocol' => node['mo_collectd']['graphite']['protocol'],
           'LogSendErrors' => true,
           'AlwaysAppendDS' => false,
           'Prefix' => "collectd.#{node.chef_environment}."
         }
  end
end
