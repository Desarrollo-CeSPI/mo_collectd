collectd_conf 'nginx' do
  plugin 'nginx'
  conf 'URL' => node['mo_collectd']['nginx']['status_url']
end

