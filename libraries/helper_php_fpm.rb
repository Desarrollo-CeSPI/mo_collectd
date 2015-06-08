#Filenames are splitted because sometimes log file has a modifier defining log format
def mo_collectd_php_fpm(instance_name, url, host, create = true)
  begin
    run_context.resource_collection.find("service[collectd]")
  rescue Chef::Exceptions::ResourceNotFound
    service 'collectd' do
      action :nothing
    end
  end


  f = ::File.join node['collectd']['extra_conf_dir'], "php-fpm-#{instance_name}.conf"
  file f do
    content "# This file is managed by Chef, your changes *will* be overwritten!\n\n" <<
      ChefCollectd::ConfigConverter.from_hash(
              'LoadPlugin' => 'curl_json',
              %w(Plugin curl_json) => {
                %W(URL #{url}) => {
                  "Instance" => "fpm_#{instance_name}",
                  "Header" => "Host: #{host|| "localhost"}",
                  %W(Key accepted\ conn) => {
                    "Type" => "fpm_http_requests"
                  },
                  %W(Key listen\ queue\ len) => {
                    "Type" => "fpm_listen_queue"
                  },
                  %W(Key active\ processes) => {
                    "Type" => "fpm_active_processes"
                  },
                  %W(Key total\ processes) => {
                    "Type" => "fpm_total_processes"
                  }
                }
              }) <<
              "\n"
    action create ? :create : :delete
    notifies :restart, "service[collectd]"
  end
end
