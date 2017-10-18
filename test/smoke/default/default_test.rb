# # encoding: utf-8

# Inspec test for recipe ohai_iis::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if os.windows?
  parent = 'C:/Users/vagrant/AppData/Local/Temp/kitchen'
  node_file = File.join(parent, 'chef_node.json')

  describe json(node_file) do
    its(['automatic', 'iis', 'sites', 'Default Web Site', 'Name']) { should eq 'Default Web Site' }
  end
end

# describe file('C:/Users/vagrant/AppData/Local/Temp/kitchen/ohai/plugins/iis.rb') do
#   it { should exist }
# end
