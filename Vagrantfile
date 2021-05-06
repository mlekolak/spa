# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "boxomatic/alpine-3.13"
  config.vm.hostname = "alpine.local"
  config.vm.box_check_update = true
  config.ssh.insert_key = false
  #NAT
  config.vm.network :forwarded_port, id: 'ssh', guest: 22, host: 2222
  config.vm.network :forwarded_port, id: 'web', guest: 80, host: 8080
  #Bridge
  # config.vm.network "public_network"

  config.vm.provision "file", source: "./nginx.conf", destination: "/home/vagrant/"
  config.vm.provision "file", source: "./Dockerfile", destination: "/home/vagrant/"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.name = "alpine"
    vb.memory = 2048
    vb.cpus = 2
   end

  config.vm.provision "shell", inline: <<-SHELL
    ip a show eth0 | grep inet
    if ip a show eth1; then
        ip a show eth1 | grep inet
    else
        echo "It looks like app is not serve in local network."
    fi
  SHELL

  config.vm.provision "shell", inline: <<-SHELL
    echo "Setting up..."
    #############################################
    #############################################
    export token=""
    export user=bonusso3
    #############################################
    #############################################
    apk add docker
    apk add git
    service docker start
    echo "net.ipv4.ip_forward = " && cat /proc/sys/net/ipv4/ip_forward
    sysctl -w net.ipv4.ip_forward=1

    echo "Cloning GIT"
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    ssh-keyscan -H github.com >> ~/.ssh/known_hosts
    git clone https://github.com/mlekolak/spa.git app

    echo "Building app"
    cd /home/vagrant/app
    cp /home/vagrant/nginx.conf .
    cp /home/vagrant/Dockerfile .
    grep 'Path' angular.json
    # sed -i -E 's/(dist\/.*)/dist\/app",/g' angular.json
    docker build -t app .
    ID="$(docker images | grep 'app' | head -n 1 | awk '{print $3}')"
    timestamp=$(date +%d%m%Y_%H%M%S)

    docker run --name app -d -p 80:80 app
    docker tag $ID $user/app:$timestamp

    sleep 5
    echo $token
    echo $user
    echo $timestamp
    status_code=$(curl --write-out %{http_code} --silent --output /dev/null localhost:80)
    if [[ "$status_code" -eq 200 ]] ; then
      echo "App is up! Test status is $status_code"
      if [ -n "$token" ] ; then
        echo "Pushing $user/app:$timestamp"
        docker login -u $user -p $token
        docker push $user/app:$timestamp
      fi
    else
      echo "Something went wrong"
      exit 1
    fi
  SHELL
end
