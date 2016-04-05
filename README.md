# KiOS

A Linux OS created by Buildroot which runs Kerberos.io out-of-the-box. This repository cross-compiles for the Raspberry Pi 1, 2 and 3. Below you can find an installation script for Ubuntu 14 and CentOS 7. When the compilation is done, three different images will be available in the current working directory.

## Install on Ubuntu 14

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

## Install on CentOS 7

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