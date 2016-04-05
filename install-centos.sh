yum install -y git hg bc perl-devel
git clone https://github.com/kerberos-io/kios
cd kios
git checkout develop
yum group install "Development Tools" -y
/root/kios/build.sh all