Ohai.plugin :Iis do
  provides 'iis/webapplications', 'iis/sites'

  collect_data :windows do
    require 'wmi-lite/wmi'

    iis(Mash.new)
    iis[:webapplications] = Mash.new
    iis[:sites] = Mash.new
    iis[:wcf] = Mash.new

    wmi = WmiLite::Wmi.new('root\WebAdministration')
    apps = wmi.instances_of('Application')
    sites = wmi.instances_of('Site')

    apps.each do |app|
      app_id = app['sitename'] + app['path']
      iis['webapplications'][app_id] = Mash.new
      app.wmi_ole_object.properties_.each do |p|
        iis['webapplications'][app_id][p.name] = app[p.name.downcase].to_s
      end
      iis['webapplications'][app_id]['VirtualDirectoryDefaults'] = Mash.new
      iis['webapplications'][app_id]['VirtualDirectoryDefaults']['LogonMethod'] = app['virtualdirectorydefaults'].logonmethod.to_s
      iis['webapplications'][app_id]['VirtualDirectoryDefaults']['PhysicalPath'] = app['virtualdirectorydefaults'].physicalpath.to_s
      iis['webapplications'][app_id]['VirtualDirectoryDefaults']['Path'] = app['virtualdirectorydefaults'].path.to_s
      iis['webapplications'][app_id]['VirtualDirectoryDefaults']['UserName'] = app['virtualdirectorydefaults'].username.to_s
    end

    sites.each do |site|
      iis['sites'][site['name']] = Mash.new
      site.wmi_ole_object.properties_.each do |p|
        iis['sites'][site['name']][p.name] = site[p.name.downcase].to_s
      end
      iis['sites'][site['name']]['Bindings'] = []
      site['bindings'].each do |bind|
        iis['sites'][site['name']]['Bindings'] << {
          'bindinginformation' => bind.bindinginformation,
          'protocol' => bind.protocol,
        }
      end
      iis['sites'][site['name']]['VirtualDirectoryDefaults'] = Mash.new
      iis['sites'][site['name']]['VirtualDirectoryDefaults']['LogonMethod'] = site['virtualdirectorydefaults'].logonmethod.to_s
      iis['sites'][site['name']]['VirtualDirectoryDefaults']['PhysicalPath'] = site['virtualdirectorydefaults'].physicalpath.to_s
      iis['sites'][site['name']]['VirtualDirectoryDefaults']['Path'] = site['virtualdirectorydefaults'].path.to_s
      iis['sites'][site['name']]['VirtualDirectoryDefaults']['UserName'] = site['virtualdirectorydefaults'].username.to_s
    end

    obj_wmi = WmiLite::Wmi.new
    services = obj_wmi.query('SELECT * FROM Win32_Service WHERE Name LIKE \'%.services%\'')

    services.each do |service|
      arr_service = service['Name'].split('.')
      arr_service.shift
      arr_service.shift
      service_name = arr_service.join('.')
      service_path = service['PathName'].split('\"')[1]

      iis['wcf'][service_name] = Mash.new
      iis['wcf'][service_name]['Name'] = service_name
      iis['wcf'][service_name]['Path'] = service_path
    end
  end
end
