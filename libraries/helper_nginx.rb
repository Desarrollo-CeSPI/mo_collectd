def mo_collectd_nginx_log(instance_name, access_log, error_log) 
  collectd_conf "nginx_log_#{instance_name}" do
    plugin 'tail'
    conf  ["File", error_log] => {
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
  end
end
