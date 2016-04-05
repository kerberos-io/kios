#CentOS 7

yum install -y git hg bc perl-devel dosfstools
curl --silent --location https://rpm.nodesource.com/setup_5.x | bash -
yum install -y php  php-xml php-gd php-curl nodejs
yum -y install epel-release && yum -y install php-mcrypt php-pdo
npm install -g bower
yum group install "Development Tools" -y
git clone https://github.com/kerberos-io/kios
cd kios
git checkout develop
./build.sh all