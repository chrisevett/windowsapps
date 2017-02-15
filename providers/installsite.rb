def whyrun_supported? # ~FC059
  true
end

action :installsite do
  if @current_resource.exists do
    Chef::Log.info "#{@new_resource} already exists"
  end
  else
    converge_by("Install #{@new_resource}") do
      install_nuget_package
    end
  end
end

def load_current_resource
  @current_resource = chef::resource::nugetclientinstall.new(@new_resource.name)
  @current_resource.site_name(@new_resource.site_name)
  @current_resource.base_install_path(@new_resource.base_install_path)
  @current_resource.package_version(@new_resource.package_version)
  @current_resource.feed_uri(@new_resource.feed_uri)
  @current_resource.protocol(@new_resource.protocol)
  @current_resource.port(@new_resource.port)
  @current_resource.pool_name(@new_resource.pool_name)
  @site_path = "#{new_resource.base_install_path}" \
               "#{new_resource.package_name}" \
               "#{new_resource.package_version}"
  verify_carbon
end


def install_site 

  nugetclient_install @new_resource.site_name do
    install_path @new_resource.base_install_path 
    package_version @new_resource.package_version 
    feed_uri @new_resource.feed_uri 
  end
  
  # create omsweb site 
  iis_site @new_resource.site_name do
    path @site_path 
    protocol @new_resource.protocol
    port @new_resource.port
  end
  
  # copy the retention script to the node
  # todo, version these and only copy if an update is made
  cookbook_file '#{@new_resource.base_path}\\retention.ps1' do
    source 'retention.ps1'
  end
  
  # retention policy, remove 5th oldest folder 
  powershell_script 'retention.ps1' do
    code '#{@new_resource.base_path}\\retention.ps1'
    cwd  '#{@new_resource.base_path}'
  end

end

private

def verify_carbon 
  run_context.include_recipe 'chocolatey'
  chocolatey 'carbon' do
    action :install
  end

  return unless ::File.directory?(@package_path)
  @current_resource.exists = true
end
