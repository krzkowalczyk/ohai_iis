require "wmi-lite/wmi"

iis = Mash.new
iis['apps'] = Mash.new

wmi = WmiLite::Wmi.new('root\WebAdministration')
apps = wmi.instances_of('Application')
apps.each do | app |
  appId = app['sitename'] + app['path']
  iis['apps'][appId] = Mash.new
  # log app.wmi_ole_object.name
  app.wmi_ole_object.properties_.each do |p|
    # log "#{p.name} = #{app[p.name.downcase]}" do
    #   level :debug
    # end
    iis['apps'][appId][p.name] = app[p.name.downcase]
  end
#  log site['physicalPath']
#log site['physicalPath']
end

iis['sites'] = Mash.new

sites = wmi.instances_of('Site')
sites.each do | site |
  # log app.wmi_ole_object.name
  iis['sites'][site['name']] = Mash.new
  site.wmi_ole_object.properties_.each do |p|
#    log "#{p.name} = #{site[p.name.downcase]}"
    iis['sites'][site['name']][p.name] = site[p.name.downcase]
  end
  iis['sites'][site['name']]['Bindings'] = []
  site['bindings'].each do |bind|
    iis['sites'][site['name']]['Bindings'] << {
      'bindinginformation' => bind.bindinginformation,
      'protocol' => bind.protocol
    }
  end
#  log site.wmi_ole_object['physicalPath']
#log site['physicalPath']
end

log iis.inspect
