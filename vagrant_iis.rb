Vagrant.configure(2) do |config|
  config.vm.provision 'shell', inline: <<-SHELL
    echo 'Installing IIS 7.5, it will take a while...'
    CMD /C START /w PKGMGR.EXE /l:log.etw /iu:IIS-WebServerRole
    echo Done!
  SHELL
end
