return unless platform?('windows')

node.default['ohai']['plugin_path'] = node['chef_client']['conf_dir'] + '/ohai/plugins'

include_recipe 'chef-client::config'

ohai_plugin 'iis' do
  name 'iis'
end
