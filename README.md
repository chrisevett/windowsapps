# windowsapps Cookbook
Utilizes the nugetclient cookbook to allow you to install serveral sites and services using one coookbook

### Platforms

Supported on windows 2008 and later.

### Chef

Chef 12.0 or later

### Cookbooks
`chocolatey` - windowsapps utilizes chocolatey to install the carbon powershell framework to install services 

## Usage

### windowsapps::installsite

```ruby
include_recipe 'windowsapps'

# webstore is the site name
windowsapps_installsite 'webstore' do
  base_install_path 'c:\\sites'
  app_version '2.6.4'
  feed_uri 'https://www.nuget.org/api/v2/'
  protocol :https
  port 443
  pool_name 'my_app_pool'
end
```

### windowsapps::installservice

```ruby
include_recipe 'windowsapps'

# poll_service is the service name
windowsapps_installservice 'poll_service' do
  base_install_path 'c:\\services'
  app_version '2.6.4'
  feed_uri 'https://www.nuget.org/api/v2/'
  description "polling service"
  display_name "pollservice"
end
```

## Contributing
Pull requests welcome.

## License and Authors
MIT
