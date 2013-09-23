name              "geminabox-server"
maintainer        "Jason Vanderhoof"
maintainer_email  "jvanderhoof@gazelle.com"
license           "Apache 2.0"
description       "Installs Geminabox server with Apache/Passenger & Ruby 1.9.3"
version           "0.0.1"
recipe            "geminabox", "Installs Geminabox as a Rack app runing with Apache/Passenger and Ruby 1.9.3."

%w{ubuntu}.each do |os|
  supports os
end

depends 'ruby_build'
depends 'passenger'

attribute "geminabox",
  :display_name => "Geminabox",
  :description => "Install Geminabox as a Rack app."
  :recipes => ["geminabox::default"]
