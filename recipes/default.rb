# #
# # Cookbook:: ohai_iis
# # Recipe:: default
# #
# # Copyright:: 2017, Krzysztof Kowalczyk, All Rights Reserved.
#
# # Enable the IIS role.
# dsc_script 'Web-Server' do
#   code <<-EOH
#   WindowsFeature Installweb
#   {
#     Name = "Web-Server"
#     Ensure = "Present"
#   }
#   EOH
# end
#
# # Install ASP.NET 4.5.
# dsc_script 'Web-Asp-Net45' do
#   code <<-EOH
#   WindowsFeature InstallDotNet45
#   {
#     Name = "Web-Asp-Net45"
#     Ensure = "Present"
#   }
#   EOH
# end
#
# # Install the IIS Management Console.
# dsc_script 'Web-Mgmt-Console' do
#   code <<-EOH
#   WindowsFeature InstallIISConsole
#   {
#     Name = "Web-Mgmt-Console"
#     Ensure = "Present"
#   }
#   EOH
# end

directory 'C:\chef\ohai\plugins' do
  recursive true
  action :create
end

# cookbook_file 'C:\chef\ohai\plugins\iis.rb' do
#   source 'iis_modules.rb'
# end

# ohai 'iis' do
#   plugin                     'iis'
#   action                     :reload
# end

include_recipe 'ohai_iis::app'
