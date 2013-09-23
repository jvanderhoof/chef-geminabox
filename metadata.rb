name              "geminabox"
maintainer        "Jason Vanderhoof"
maintainer_email  "jvanderhoof@gazelle.com"
license           "Apache 2.0"
description       "Installs Geminabox server with Apache/Passenger & Ruby 1.9.3"
version           "0.0.1"
recipe            "geminabox::default", "Installs Geminabox as a Rack app runing with Apache/Passenger and Ruby 1.9.3."

%w{ubuntu}.each do |os|
  supports os
end

depends 'ruby_build', "~> 0.8.1"
depends 'passenger', "~> 0.1.0"

attribute "geminabox",
  :display_name => "Geminabox Configuration",
  :type => "hash"

attribute "geminabox/authentication",
  :display_name => 'Authentication',
  :type => 'string',
  :required => "required",
  :recipes => ["geminabox::default"],
  :default => 'none',
  :choice => ['basic','none']

attribute "geminabox/username",
  :display_name => 'Authentication Username',
  :type => 'string',
  :required => "recommended",
  :recipes => ["geminabox::default"],
  :default => ''

attribute "geminabox/password",
  :display_name => 'Authentication Password',
  :type => 'string',
  :required => "recommended",
  :recipes => ["geminabox::default"],
  :default => ''

attribute "geminabox/path",
  :display_name => 'Data Path',
  :type => 'string',
  :required => "recommended",
  :recipes => ["geminabox::default"],
  :default => '/var/geminabox'



