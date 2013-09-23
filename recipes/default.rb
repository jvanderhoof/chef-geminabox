# install disired Ruby version
ruby_build_ruby '1.9.3-p448' do
  action :install
end

# install required gems
ruby_bin = "/usr/local/ruby/1.9.3-p448/bin"
[
  {:name => 'bundler', :version => '1.3.5'},
  {:name => 'geminabox', :version => '0.11.0'},
  {:name => 'rubygems-update', :version => '2.1.3'}
].each do |gem_pkg|
  gem_package gem_pkg[:name] do
    version gem_pkg[:version]
    gem_binary "#{ruby_bin}/gem"
    options '--no-ri --no-rdoc'
  end
end

execute "upgrade rubygems" do
  command "#{ruby_bin}/gem update --system"
  user "root"
end

# hack to allow default builtin ruby to handle install of passenger
gem_package 'rake' do
  options '--no-ri --no-rdoc'
end

node[:passenger][:version] = node[:geminabox][:passenger_version] if node[:geminabox][:passenger_version]
node[:passenger][:module_path] = "#{node[:passenger][:root_path]}/buildout/apache2/mod_passenger.so"
node[:passenger][:default_ruby] = "#{ruby_bin}/ruby"
include_recipe 'passenger'

node[:passenger][:rack_app] = [{
          :name => 'gemserver',
          :server_name => 'gemserver.dev',
          :docroot => '/var/geminabox',
        }]
include_recipe 'passenger::mod_rails'

%w{data public tmp}.each do |folder|
  directory "#{node[:geminabox][:path]}/#{folder}" do
    owner "www-data"
    group "www-data"
    action :create
    recursive true
  end
end

template "#{node[:geminabox][:path]}/config.ru" do
  owner "www-data"
  group "www-data"
  source "config.ru.erb"
  variables({
    :authentication  => node[:geminabox][:authentication],
    :username        => node[:geminabox][:username],
    :password        => node[:geminabox][:password],
  })
end
