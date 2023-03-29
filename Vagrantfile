# Description: Vagrantfile for k8s cluster with 1 master and 2 workers
Vagrant.configure("2") do |config|
    # Master Nodes
    MasterCount = 1
    (1..MasterCount).each do |i|
        config.vm.define "k8s-master-#{i}" do |vv|
            vv.vm.box = "bento/ubuntu-20.04-arm64"
            vv.vm.box_version = "202301.20.0"
            vv.vm.hostname = "k8s-master-#{i}"
            vv.vm.network "private_network", ip: "172.16.1.1#{i}"

            vv.vm.provider "parallels" do |vb|
                vb.name = "k8s-master-#{i}"
                vb.memory = 1024
                vb.cpus = 2
            end
        end
    end

    # Worker Nodes
    WorkerCount = 2
    (1..WorkerCount).each do |i|
        config.vm.define "k8s-worker-#{i}" do |vv|
            vv.vm.box = "bento/ubuntu-20.04-arm64"
            vv.vm.box_version = "202301.20.0"
            vv.vm.hostname = "k8s-worker-#{i}"
            vv.vm.network "private_network", ip: "172.16.2.1#{i}"

            vv.vm.provider "parallels" do |vb|
                vb.name = "k8s-worker-#{i}"
                vb.memory = 1024
                vb.cpus = 2
            end
        end
    end

    config.vm.provision "shell" do |s|
        ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
        s.inline = <<-SHELL
            # Create ci user
            useradd -s /bin/bash -d /home/ci/ -m -G sudo ci
            echo 'ci ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
            mkdir -p /home/ci/.ssh && chown -R ci /home/ci/.ssh
            echo #{ssh_pub_key} >> /home/ci/.ssh/authorized_keys
        SHELL
    end
end