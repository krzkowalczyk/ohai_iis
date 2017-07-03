Ohai.plugin :Iis do
  provides 'iis/modules'

  collect_data :default do
    # require 'win32ole'
    #
    # # Connect to the WMI WebAdministration namespace.
    # web_admin = WIN32OLE.connect("winmgmts:root\\WebAdministration")
    # app_pool = web_admin.get("WebApplication.Name='DefaultAppPool'")

    iis(Mash.new)
    iis[:modules] = 'sss'
#    iis[:modules] << 'test'

    print 'test'
  end
end
