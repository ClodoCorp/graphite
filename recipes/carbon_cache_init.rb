#
# Cookbook Name:: graphite
# Recipe:: carbon_cache_init
#
# Copyright 2011, Heavy Water Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'debian'
  package 'daemon'

  node['graphite']['carbon']['caches'].each do |key,data|
    template "/etc/init.d/carbon-cache-#{key}" do
      source 'carbon.debian.init.erb'
      variables(
        :name => "cache",
        :instance => key,
        :user => node['graphite']['user_account']
      )
      mode 00755
      notifies :restart, "service[carbon-cache-#{key}]"
    end

    service "carbon-cache" do
      action [:disable, :stop]
    end
    service "carbon-cache-#{key}" do
      action [:enable, :start]
      subscribes :restart, "template[#{node['graphite']['carbon']['conf_dir']}/carbon.conf]"
    end
  end
end
