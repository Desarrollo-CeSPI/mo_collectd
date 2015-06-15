# instance_name is a string to identify this statistic. 
# directories is a Hash whith: instance name as key and path as directory
def mo_collectd_file_count(instance_name, directories, create = true)
  begin
    run_context.resource_collection.find("service[collectd]")
  rescue Chef::Exceptions::ResourceNotFound
    service 'collectd' do
      action :nothing
    end
  end


  f = ::File.join node['collectd']['extra_conf_dir'], "file-count-#{instance_name}.conf"
  file f do
    content "# This file is managed by Chef, your changes *will* be overwritten!\n\n" <<
      ChefCollectd::ConfigConverter.from_hash(
              'LoadPlugin' => 'filecount',
              %w(Plugin filecount) => Hash[directories.map { |instance, path| [ %W(Directory #{path}), {"Instance" => instance} ] }]
              ) <<
              "\n"
    action create ? :create : :delete
    notifies :restart, "service[collectd]"
  end
end
