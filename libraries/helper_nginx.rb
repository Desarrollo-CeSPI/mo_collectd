#Filenames are splitted because sometimes log file has a modifier defining log format
def mo_collectd_nginx_log(instance_name, access_log, error_log, create=true) 
  begin
    run_context.resource_collection.find("service[collectd]")
  rescue Chef::Exceptions::ResourceNotFound
    service 'collectd' do
      action :nothing
    end
  end

  f = ::File.join node['collectd']['extra_conf_dir'], "#{instance_name}.conf"
  file f do
    content "# This file is managed by Chef, your changes *will* be overwritten!\n\n" <<
      ChefCollectd::ConfigConverter.from_hash(
              'LoadPlugin' => 'tail',
              %w(Plugin tail) => {
                ["File", error_log.split.first] => {
                  "Instance" => "#{instance_name}",
                  "Match" => {
                    "Regex"     => ".*",
                    "DSType"    => "CounterInc",
                    "Type"      => "counter",
                    "Instance"  => "errors"
                  },
                },
                ["File", access_log.split.first] => {
                  "Instance" => "#{instance_name}",
                  "Match" => {
                    "Regex"     => ".*",
                    "DSType"    => "CounterInc",
                    "Type"      => "counter",
                    "Instance"  => "requests"
                  }
                }
              }) <<
              "\n"
    action create ? :create : :delete
    notifies :restart, "service[collectd]"
  end
end
