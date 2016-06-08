#Ubuntu 14

apt-get update
apt-get install -y git build-essential unzip mercurial php5 php5-gd mcrypt php5-mcrypt php5-curl
php5enmod mcrypt
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
apt-get install -y nodejs npm nodejs-legacy
npm install -g bower
git clone https://github.com/kerberos-io/kios
cd kios
git checkout develop
./build.sh all
./build.sh all mkrelease
