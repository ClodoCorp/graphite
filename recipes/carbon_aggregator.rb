#
# Cookbook Name:: graphite
# Recipe:: carbon_aggregator
#
# Copyright 2013, Onddo Labs, SL.
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

service_type = node['graphite']['carbon']['service_type']

# aggregation-rules.conf file is automatically reloaded by the carbon-aggregator process.
# There is no need to restart the application.
if node[:platform_family].include?("debian")
  if node['graphite']['aggregation_rules'].is_a?(Array) && node['graphite']['aggregation_rules'].length > 0
    template "#{node['graphite']['carbon']['conf_dir']}/aggregation-rules.conf" do
      owner node['graphite']['user_account']
      group node['graphite']['group_account']
      variables(:aggregation_rules => node['graphite']['aggregation_rules'])
    end
  else
    file "#{node['graphite']['carbon']['conf_dir']}/conf/aggregation-rules.conf" do
      action :delete
    end
  end
else
  if node['graphite']['aggregation_rules'].is_a?(Array) && node['graphite']['aggregation_rules'].length > 0
    template "#{node['graphite']['base_dir']}/conf/aggregation-rules.conf" do
      owner node['graphite']['user_account']
      group node['graphite']['group_account']
      variables(:aggregation_rules => node['graphite']['aggregation_rules'])
    end
  else
    file "#{node['graphite']['base_dir']}/conf/aggregation-rules.conf" do
      action :delete
    end
  end
end

include_recipe "#{cookbook_name}::#{recipe_name}_#{service_type}"
