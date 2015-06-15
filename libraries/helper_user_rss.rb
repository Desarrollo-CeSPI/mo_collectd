#Filenames are splitted because sometimes log file has a modifier defining log format
def mo_collectd_user_rss(user, create = true)
  begin
    run_context.resource_collection.find("service[collectd]")
  rescue Chef::Exceptions::ResourceNotFound
    service 'collectd' do
      action :nothing
    end
  end


  f = ::File.join node['collectd']['extra_conf_dir'], "user-rss-#{user}.conf"
  file f do
    content "# This file is managed by Chef, your changes *will* be overwritten!\n\n" <<
      ChefCollectd::ConfigConverter.from_hash(
              'LoadPlugin' => 'exec',
              %w(Plugin exec) => {
                  "Exec" => "#{user}\" \"#{node['mo_collectd']['user_rss']['script']}\" \"#{user}",
                }
              ) <<
              "\n"
    action create ? :create : :delete
    notifies :restart, "service[collectd]"
  end
end
