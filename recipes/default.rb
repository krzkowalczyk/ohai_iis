return unless platform?('windows')

include_recipe 'chef-client::config'

if node['ohai_iis']['install-Web-Scripting-Tools']
  windows_feature ['Web-Scripting-Tools'] do
    action :install
    install_method :windows_feature_powershell
    guard_interpreter :powershell_script
    only_if 'Import-Module ServerManager; (Get-WindowsFeature | where {$_.name -eq "Web-Server"}).installed'
  end
end

ohai_plugin 'iis' do
  name 'iis'
  guard_interpreter :powershell_script
  compile_time false if node['ohai_iis']['install-Web-Scripting-Tools']
  only_if 'Import-Module ServerManager; (Get-WindowsFeature | where {$_.name -eq "Web-Server"}).installed'
end
