Vagrant.configure("2") do |config|

  config.vm.box = "debian/testing64"

  config.vm.define "redis-1" do |redis1|
    redis1.vm.hostname = "redis-1"
    redis1.vm.network "private_network", ip: "192.168.56.101"
    redis1.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "1"
    end
  end

  config.vm.define "postgresql-1" do |pg1|
    pg1.vm.hostname = "postgresql-1"
    pg1.vm.network "private_network", ip: "192.168.56.102"
    pg1.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "1"
    end
  end

  config.vm.define "poll-1" do |poll1|
    poll1.vm.hostname = "poll-1"
    poll1.vm.network "private_network", ip: "192.168.56.103"
    poll1.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "1"
    end
  end

  config.vm.define "result-1" do |result1|
    result1.vm.hostname = "result-1"
    result1.vm.network "private_network", ip: "192.168.56.104"
    result1.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "1"
    end
  end

  config.vm.define "worker-1" do |worker1|
    worker1.vm.hostname = "worker-1"
    worker1.vm.network "private_network", ip: "192.168.56.105"
    worker1.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "1"
    end
  end
end
