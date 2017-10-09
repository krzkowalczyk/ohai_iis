require 'spec_helper'

describe_ohai_plugin :Iis do
  let(:plugin_file) { 'files/default/iis.rb' }

  before(:each) do
    allow(plugin).to receive(:collect_os).and_return(:windows)
  end

  it 'provides iis/webapplications' do
    expect(plugin).to provides_attribute('iis/webapplications')
  end

  let(:command) { double('Fake Command',stdout: 'OUTPUT') }

end
