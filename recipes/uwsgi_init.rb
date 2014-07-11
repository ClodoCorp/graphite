directory '/var/log/graphite-web' do
  mode 00700
  owner node['graphite']['user_account']
  group node['graphite']['group_account']
end 

template '/etc/init.d/graphite-web' do
  source 'uwsgi.init.erb'
  mode 00755
  notifies :restart, 'service[graphite-web]', :delayed
end

service 'graphite-web' do
  action [:enable, :start]
end
