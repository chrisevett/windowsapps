require "pry-byebug"
use_inline_resources 

def whyrun_supported? # ~FC059
  true
end

action :install do
  if @current_resource.exists do
    Chef::Log.info "#{@new_resource} already exists"
  end
  else
    converge_by("Install #{@new_resource}") do
      install_service 
    end
  end
end

def load_current_resource
  @current_resource = Chef::Resource::WindowsappsInstallservice.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.file_name(@new_resource.file_name)
  @current_resource.base_install_path(@new_resource.base_install_path)
  @current_resource.package_version(@new_resource.package_version)
  @current_resource.feed_uri(@new_resource.feed_uri)
  @current_resource.description(@new_resource.description)
  @current_resource.display_name(@new_resource.display_name)
  @service_path = "#{new_resource.base_install_path}\\" \
               "#{new_resource.file_name}." \
               "#{new_resource.package_version}\\" \
               "#{new_resource.file_name}\\"

end


def install_service
  #run_context.include_recipe 'chocolatey'
  chocolatey 'carbon' do
    action :install
  end

  nugetclient_install new_resource.name do
    action :install
    install_path new_resource.base_install_path 
    package_version new_resource.package_version 
    feed_uri new_resource.feed_uri 
  end

  # note: carbon handles idempotence here
  powershell_script 'carbon_install_script' do
    code <<-EOH
    Install-Service -Name #{new_resource.name} `
                    -DisplayName #{new_resource.display_name} `
                    -Description #{new_resource.description}  `
                    -Path #{@service_path}
    EOH
  end
  
end
