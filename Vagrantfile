Vagrant.configure(2) do |config|
    # Collect data about the host
    case RbConfig::CONFIG['host_os']
        when /cygwin|mswin|msys|mingw|bccwin|wince|emc|emx|windows/i
            # Windows
            cpus = `wmic cpu get NumberOfLogicalProcessors`.split("\n")[2].to_i
        when /linux|arch/i
            # linux
            cpus = `nproc`.to_i
        when /darwin|mac os/i
            # MacOS
            cpus = `sysctl -n hw.ncpu`.to_i
        else
            # Others...
            cpus = 2
    end

    config.vm.define "Neap Box" do |node|
        # For a complete reference, please see the online documentation at
        # https://docs.vagrantup.com.

        # General configuration
        node.vm.hostname = "box.neap.dev"
        node.vm.box = "debian/contrib-jessie64"
        node.vm.box_version = "= 8.5.2"

        # Synced folder configuration
        node.vm.synced_folder ".", "/vagrant"

        # VirtualBox provider
        node.vm.provider "virtualbox" do |provider|
            # System configuration
            provider.name = "Neap Box"
            provider.cpus = cpus
            provider.memory = "1024"
        end

        #  VirtualBox Guest update
        node.vbguest.auto_update = true
        node.vbguest.installer = DebianVbguest
        node.vbguest.no_remote = true

        # Digital Ocean provider
        node.vm.provider "digital_ocean" do |provider, override|
            override.nfs.functional = false
            override.ssh.private_key_path = 'resources/digital-ocean/id_rsa'
            override.vm.box = 'digital_ocean'
            override.vm.box_url = 'https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box'

            token = ''
            begin
                File.open('resources/digital-ocean/token', 'r') do |file|
                    while (line = file.gets)
                        token = line
                        break
                    end
                end
            rescue SystemCallError
            end
            provider.token = token
            provider.image = 'debian-8-x64'
            provider.region = 'lon1'
            provider.size = '512mb'
        end

        # Provisioning script
        node.vm.provision "shell" do |s|
            s.inline = "/vagrant/bootstrap.sh | tee /vagrant/bootstrap.log"
            s.keep_color = true
        end
    end
end

class DebianVbguest < VagrantVbguest::Installers::Debian
  def install(opts=nil, &block)
    communicate.sudo('apt-get -y -q purge virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11', opts, &block)
    @vb_uninstalled = true
    super
  end

  def running?(opts=nil, &block)
    return false if @vb_uninstalled
    super
  end
end
