#
# Cookbook Name:: symphony
# Recipe:: default
#
# Copyright 2009-2013, Skystack Limited.
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

node["sites"].each do |site|

  if site['config']['software'] == "symphony"
    
    application_set = site['config']['set']
    webserver = site['config']['webserver']
    
    syDb = {}

    node["databases"].each do |db|
      if db['config']['set'] == application_set
        syDb = db
      end
    end

    site_fqdn = site['server_name']
    site_dir = site['document_root']

    if node['symphony']['version'] == 'master'

      local_file = "#{Chef::Config[:file_cache_path]}/symphony-master.zip"

        remote_file "#{local_file}" do
          source "https://github.com/symphonycms/symphony-2/archive/master.zip"
          mode "0644"
         # action :create_if_missing
        end

    else

      remote_file "#{Chef::Config[:file_cache_path]}/symphony-#{node['symphony']['branch']}.tar.gz" do
        source "http://wordpress.org/wordpress-#{node['symphony']['branch']}.tar.gz"
        mode "0644"
      end

    end

    directory "#{site_dir}" do
      owner "root"
      group "root"
      mode "0755"
      action :create
      recursive true
    end

    execute "unzip-symphony" do
      cwd site_dir
      command "unzip #{local_file}"
      creates "#{site_dir}/symphony-2-master/index.php"
    end

    execute "move symphony files"
      cwd "#{site_dir}"
      command "mv symphony-2-master/* ."
      only_if do File.exists?("#{site_dir}/symphony-2-master") end
    end

    execute "remove symfony-2-master directory"
      cwd "#{site_dir}"
      command "rm -rf symphony-2-master"
      only_if do File.exists?("#{site_dir}/symphony-2-master") end
    end

    execute "give the webserver ownership over this directory"
      cwd "#{site_dir}"
      command "chown -R www-data:www-data #{site_dir}"
      only_if do File.exists?("#{site_dir}") end
    end

    log "Navigate to 'http://#{site_fqdn}/install/' to complete symphony installation" do
      action :nothing
    end

    service webserver do
      action :restart
    end

  end

end



