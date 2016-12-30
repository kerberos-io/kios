
#KERBEROS.IO
[![Join the chat at https://gitter.im/kerberos-io/hades](https://img.shields.io/badge/GITTER-join chat-green.svg)](https://gitter.im/kerberos-io/hades?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Kerberos.io - video surveillance](https://kerberos.io/images/kerberos.png)](https://kerberos.io)

## Vote for features

[![Feature Requests](http://feathub.com/kerberos-io/machinery?format=svg)](http://feathub.com/kerberos-io/machinery)

## What is KiOS?
A Linux OS created by Buildroot which runs Kerberos.io out-of-the-box. This repository cross-compiles for the Raspberry Pi 1, 2 and 3. Below you can find an installation script for Ubuntu 14 and CentOS 7. When the compilation is done, three different images will be available in the current working directory.

### How to install KiOS on your Raspberry Pi?
Please go to our [documentation website](https://doc.kerberos.io/2.0/installation/KiOS), there is explained the complete process to get started with Kerberos.io.

### How to build KiOS on Ubuntu 14

    # Install dependencies
    
    apt-get update
    apt-get install -y git build-essential unzip mercurial php5 php5-gd mcrypt php5-mcrypt php5-curl
    php5enmod mcrypt
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    apt-get install -y nodejs npm nodejs-legacy
    npm install -g bower
    
    # Cloning the source code
    
    git clone https://github.com/kerberos-io/kios
    cd kios
    git checkout develop
    
    # Creating releases for Raspberry Pi 1, 2 and 3
    
    ./build.sh all
    ./build.sh all mkrelease

### How to build KiOS on CentOS 7

    # Install dependencies
    
    yum install -y git hg bc perl-devel dosfstools
    curl --silent --location https://rpm.nodesource.com/setup_5.x | bash -
    yum install -y php  php-xml php-gd php-curl nodejs
    yum -y install epel-release && yum -y install php-mcrypt php-pdo
    npm install -g bower
    yum group install "Development Tools" -y

    # Cloning the source code
    
    git clone https://github.com/kerberos-io/kios
    cd kios
    git checkout develop

    # Creating releases for Raspberry Pi 1, 2 and 3
    
    ./build.sh all
    ./build.sh all mkrelease

##How to build KiOS on DigitalOcean
If you don't want to build KiOS on your local workingstation but you prefer to build it on a VM at DigitalOcean you're at the right place. You will find a script at the root of the KiOS repository named `deploy.py`.

The python script will need some environment variables and use the DigitalOcean API to create a VM, build KiOS, transfer the images to your local workingstation and destory the VM again.

### Environment variables
You'll need to define severable variables; you can add these at the beginning of the deploy script or EXPORT them at your commandline.

    # The token from your DigitalOcean account
    os.environ['kerberosio_token'] = 'cdae884ef42585ca35e797bc0a2209ff9c5f94f1c59f15f7c3bcb9722bd17261'
    
    # The name of the VM you will create; this doesn't matter at all..
    os.environ['kerberosio_server_name'] = 'buildroot.cedricverstraeten.be'
    
    # If you have added an SSH key to DigitalOcean, you can select it
    os.environ['kerberosio_ssh_key'] = 'a1:50:01:fd:60:27:62:27:5d:aa:83:b0:c5:54:0c:37'
    
    # Define the id of the image, you'd like to use (e.g. Ubuntu 14)
    os.environ['kerberosio_image_id'] = '16724351'
    
    # The location of where to install KiOS on the VM
    os.environ['kerberosio_kios_dir'] = '/root/kios/'
    
    # The location on your local workingstation where the images should be stored.
    os.environ['kerberosio_release_dir'] = '/Users/cedricverst/Desktop/'


After you've defined the environment variables you can simply run the script and you will have some freshly build KiOs images. Hurray!
