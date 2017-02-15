if defined?(ChefSpec)
  ChefSpec.define_matcher(:windowsapps_installsite)
  ChefSpec.define_matcher(:windowsapps_installservice)

  def installsite_windowsapp(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:windowsapps_installsite,
                                            :installsite,
                                            resource)
  end
  def installservice_windowsapp(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:windowsapps_installservice,
                                            :installservice,
                                            resource)
  end
end
