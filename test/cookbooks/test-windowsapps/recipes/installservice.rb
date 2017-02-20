#
# Cookbook Name:: test-windowsapps
# Recipe:: test-windowsapps:installservice 
#
# MIT license

include_recipe 'windowsapps'

windowsapps_installservice 'butt' do
  action :install
  file_name 'buttservicename.exe'
  base_install_path 'c:\\chef_staging'
  package_version '2.6.4'
  feed_uri 'https://www.nuget.org/api/v2/'
  description 'my butt service lool'
  display_name 'buttse.rvice'
end
