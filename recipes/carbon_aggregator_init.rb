#
# Cookbook Name:: graphite
# Recipe:: carbon_aggregator_init
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

template '/etc/init.d/carbon-aggregator' do
  source 'carbon.init.erb'
  variables(
    :name    => 'aggregator',
    :dir     => node['graphite']['base_dir'],
    :user    => node['graphite']['user_account']
  )
  mode 00744
  notifies :restart, 'service[carbon-aggregator]'
end

service 'carbon-aggregator' do
  action [:enable, :start]
  subscribes :restart, "template[#{node['graphite']['base_dir']}/conf/carbon.conf]"
end
