actions :install
default_action :install

attribute :name, kind_of: String, required: true, name_attribute: true
attribute :file_name, kind_of: String, required: true
attribute :base_install_path, kind_of: String, required: true
attribute :package_version, kind_of: String, required: true
attribute :feed_uri, kind_of: String, required: true
attribute :description, kind_of: String, required: true
attribute :display_name, kind_of: String, required: true

attr_accessor :exists
