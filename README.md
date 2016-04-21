
#KERBEROS.IO
[![Join the chat at https://gitter.im/kerberos-io/hades](https://img.shields.io/badge/GITTER-join chat-green.svg)](https://gitter.im/kerberos-io/hades?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Kerberos.io - video surveillance](https://kerberos.io/images/kerberos.png)](https://kerberos.io)

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
    apt-get install -y nodejs npm
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
