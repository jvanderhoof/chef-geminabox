unless node[:geminabox][:rbenv][:enabled]
  gem_package "geminabox" do
    version node[:geminabox][:version] if node[:geminabox][:version]
  end
else
  rbenv_gem "geminabox" do
    rbenv_version node[:geminabox][:rbenv][:version]
    version node[:geminabox][:version] if node[:geminabox][:version]
  end
end

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
end