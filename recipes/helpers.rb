package 'bc'

cookbook_file node['mo_collectd']['user_rss']['script'] do
  source 'user-rss.sh'
  mode '0755'
end
