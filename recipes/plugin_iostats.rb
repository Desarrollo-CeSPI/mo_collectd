include_recipe "mo_collectd::_libpython"
package 'sysstat'

filename = 'iostat_types.db'
types_db = ::File.join node['collectd']['conf_dir'], filename

cookbook_file filename do
  path types_db
end

cookbook_file File.join(node[:collectd][:plugin_dir], "collectd_iostat_python.py") do
  owner "root"
  group "root"
  mode "644"
end

f = ::File.join node['collectd']['extra_conf_dir'], "collectd_iostats.conf"

file f do
    content "# This file is managed by Chef, your changes *will* be overwritten!\n\n" <<
    ChefCollectd::ConfigConverter.from_hash(
      'TypesDB' => types_db,
      %W(LoadPlugin python) => {'Globals' => true},
      %W(Plugin python) => {
          'ModulePath' => node['collectd']['plugin_dir'],
          'Import' => 'collectd_iostat_python',
          %w(Module collectd_iostat_python) => {
            'Path'        => "/usr/bin/iostat",
            'Interval'    => 2,
            'Count'       => 2,
            'Verbose'     => false,
            'NiceNames'   => false,
            'PluginName'  => 'collectd_iostat_python'
          }
    }) <<
    "\n"
    notifies :restart, "service[collectd]"
end

