actions :installsite
default_action :installsite

attribute :site_name, kind_of: String, required: true, name_attribute: true
attribute :base_install_path, kind_of: String, required: true
attribute :package_version, kind_of: String, required: true
attribute :feed_uri, kind_of: String, required: true
attribute :protocol, kind_of: [:http, :https], required: true
attribute :port, kind_of: Fixnum, required: true
attribute :pool_name, kind_of: String:, required: true

attr_accessor :exists
