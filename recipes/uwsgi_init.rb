template '/etc/init.d/graphite-web' do
  source 'uwsgi.init.erb'
  mode 00755
  notifies :restart, 'service[graphite-web]', :delayed
end

service 'graphite-web' do
  action [:enable, :start]
end
