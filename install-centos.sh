yum install -y git
git clone https://github.com/kerberos-io/kios
cd kios
git checkout develop
yum group install "Development Tools" -y
yum install hg bc -y
/root/kios/build.sh all