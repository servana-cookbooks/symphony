maintainer       "Tass Skoudros"
maintainer_email "team@skystack.com"
license          "Apache 2.0"
description      "Installs/Configures Symphony"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

recipe "Symphony", "Installs and configures Symphony stack on a single system"

%w{ php openssl }.each do |cb|
  depends cb
end

depends "apache2", ">= 0.99.4"
depends "mysql", ">= 1.0.5"

%w{ debian ubuntu }.each do |os|
  supports os
end

attribute "symphony/version",
  :display_name => "Symphony download version",
  :description => "Version of WordPress to download from the Symphony site or 'master' for the current release.",
  :default => "master"

attribute "symphony/dir",
  :display_name => "Symphony installation directory",
  :description => "Location to place Symphony files.",
  :default => "/var/www/symphony"