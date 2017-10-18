#
# Cookbook:: ohai_iis
# Spec:: default
#
# Copyright:: 2017, Krzysztof Kowalczyk, All Rights Reserved.

require 'spec_helper'

describe 'ohai_iis::default' do
  context 'When all attributes are default, on an Windows 2008R2' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2008R2')
      runner.converge(described_recipe)
    end

    before do
      stub_const('WIN32OLE', Module.new) unless defined?(WIN32OLE)
      allow(WIN32OLE).to receive(:connect).and_return(double(ExecQuery: []))
      stub_command('Import-Module ServerManager; (Get-WindowsFeature | where {$_.name -eq "Web-Server"}).installed').and_return(true)
    end

    it 'installs ohai plugin' do
      expect(chef_run).to create_ohai_plugin('iis')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on an Windows 2012R2' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012R2')
      runner.converge(described_recipe)
    end

    before do
      stub_const('WIN32OLE', Module.new) unless defined?(WIN32OLE)
      allow(WIN32OLE).to receive(:connect).and_return(double(ExecQuery: []))
      stub_command('Import-Module ServerManager; (Get-WindowsFeature | where {$_.name -eq "Web-Server"}).installed').and_return(true)
    end

    it 'installs ohai plugin' do
      expect(chef_run).to create_ohai_plugin('iis')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on an Windows 2016' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2016')
      runner.converge(described_recipe)
    end

    before do
      stub_const('WIN32OLE', Module.new) unless defined?(WIN32OLE)
      allow(WIN32OLE).to receive(:connect).and_return(double(ExecQuery: []))
      stub_command('Import-Module ServerManager; (Get-WindowsFeature | where {$_.name -eq "Web-Server"}).installed').and_return(true)
    end

    it 'installs ohai plugin' do
      expect(chef_run).to create_ohai_plugin('iis')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, and IIS is not installed' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2016')
      runner.converge(described_recipe)
    end

    before do
      stub_const('WIN32OLE', Module.new) unless defined?(WIN32OLE)
      allow(WIN32OLE).to receive(:connect).and_return(double(ExecQuery: []))
      stub_command('Import-Module ServerManager; (Get-WindowsFeature | where {$_.name -eq "Web-Server"}).installed').and_return(false)
    end

    it 'installs ohai plugin' do
      expect(chef_run).to_not create_ohai_plugin('iis')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
