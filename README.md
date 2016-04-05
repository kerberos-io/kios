# KiOS

A Linux OS created by Buildroot which runs Kerberos.io out-of-the-box. This repository cross-compiles for the Raspberry Pi 1, 2 and 3.

## Install on CentOS 7

Below you can find an installation script for CentOS 7. When the compilation is done, three different images will be available in the current working directory.

    #Install dependencies
    
    yum install -y git hg bc perl-devel 
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