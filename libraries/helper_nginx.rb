def mo_collectd_nginx_log(instance_name, access_log, error_log, create=true) 
  f = ::File.join node['collectd']['extra_conf_dir'], "#{instance_name}.conf"
  file f do
    content "# This file is managed by Chef, your changes *will* be overwritten!\n\n" <<
      ChefCollectd::ConfigConverter.from_hash(
              'LoadPlugin' => 'tail',
              %w(Plugin tail) => {
                ["File", error_log] => {
                  "Instance" => "#{instance_name}",
                  "Match" => {
                    "Regex"     => ".*",
                    "DSType"    => "CounterInc",
                    "Type"      => "counter",
                    "Instance"  => "errors"
                  },
                },
                ["File", access_log] => {
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
  end
end
