#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)";

echo "Compiling Kerberos.io for each board"

rm -rf $DIR/kios-*
rm -rf $DIR/dl/kerberosio-*
rm -rf $DIR/output/raspberrypi/build/kerberosio-*
rm -rf $DIR/output/raspberrypi2/build/kerberosio-*
rm -rf $DIR/output/raspberrypi3/build/kerberosio-*
rm -rf $DIR/output/raspberrypi4/build/kerberosio-*

$DIR/build.sh raspberrypi
$DIR/build.sh raspberrypi mkimage
$DIR/build.sh raspberrypi mkrelease

$DIR/build.sh raspberrypi2
$DIR/build.sh raspberrypi2 mkimage
$DIR/build.sh raspberrypi2 mkrelease

$DIR/build.sh raspberrypi3
$DIR/build.sh raspberrypi3 mkimage
$DIR/build.sh raspberrypi3 mkrelease

$DIR/build.sh raspberrypi4
$DIR/build.sh raspberrypi4 mkimage
$DIR/build.sh raspberrypi4 mkrelease

echo "Creating Kerberos.io releases per board"

mkdir -p $DIR/releases
DATE=$(date +%Y%m%d)

echo "Preparing release for Raspberry Pi board"

mkdir -p $DIR/releases/rpi/$DATE
cp $DIR/output/raspberrypi/images/kios-raspberrypi-*.gz $DIR/releases/rpi/$DATE
for file in $DIR/output/raspberrypi/build/kerberosio-machinery*/kerberosio*; do cp -v -- "$file" "$DIR/releases/rpi/$DATE/rpi1-machinery-${file##*/}"; done
cd $DIR/output/raspberrypi/target/var/www/web && sed -i 's/\/data\/machinery\/config/\/\etc\/opt\/kerberosio\/config/g' config/app.php && tar czf $DIR/releases/rpi/$DATE/web.tar.gz .
cp $DIR/output/raspberrypi/target/usr/lib/libx265.so.160 $DIR/releases/rpi/$DATE/rpi-libx265.so.160

echo "Preparing release for Raspberry Pi 2 board"

mkdir -p $DIR/releases/rpi2/$DATE
cp $DIR/output/raspberrypi2/images/kios-raspberrypi2-*.gz $DIR/releases/rpi2/$DATE
for file in $DIR/output/raspberrypi2/build/kerberosio-machinery*/kerberosio*; do cp -v -- "$file" "$DIR/releases/rpi2/$DATE/rpi2-machinery-${file##*/}"; done
cd $DIR/output/raspberrypi2/target/var/www/web && sed -i 's/\/data\/machinery\/config/\/\etc\/opt\/kerberosio\/config/g' config/app.php && tar czf $DIR/releases/rpi2/$DATE/web.tar.gz .
cp $DIR/output/raspberrypi2/target/usr/lib/libx265.so.160 $DIR/releases/rpi2/$DATE/rpi2-libx265.so.160

echo "Preparing release for Raspberry Pi 3 board"

mkdir -p $DIR/releases/rpi3/$DATE
cp $DIR/output/raspberrypi3/images/kios-raspberrypi3-*.gz $DIR/releases/rpi3/$DATE
for file in $DIR/output/raspberrypi3/build/kerberosio-machinery*/kerberosio*; do cp -v -- "$file" "$DIR/releases/rpi3/$DATE/rpi3-machinery-${file##*/}"; done
cd $DIR/output/raspberrypi3/target/var/www/web && sed -i 's/\/data\/machinery\/config/\/\etc\/opt\/kerberosio\/config/g' config/app.php && tar czf $DIR/releases/rpi3/$DATE/web.tar.gz .
cp $DIR/output/raspberrypi3/target/usr/lib/libx265.so.160 $DIR/releases/rpi3/$DATE/rpi3-libx265.so.160

echo "Preparing release for Raspberry Pi 4 board"

mkdir -p $DIR/releases/rpi4/$DATE
cp $DIR/output/raspberrypi4/images/kios-raspberrypi4-*.gz $DIR/releases/rpi4/$DATE
for file in $DIR/output/raspberrypi4/build/kerberosio-machinery*/kerberosio*; do cp -v -- "$file" "$DIR/releases/rpi4/$DATE/rpi4-machinery-${file##*/}"; done
cd $DIR/output/raspberrypi4/target/var/www/web && sed -i 's/\/data\/machinery\/config/\/\etc\/opt\/kerberosio\/config/g' config/app.php && tar czf $DIR/releases/rpi4/$DATE/web.tar.gz .
cp $DIR/output/raspberrypi4/target/usr/lib/libx265.so.160 $DIR/releases/rpi4/$DATE/rpi4-libx265.so.160
#echo "Uploading last release to Github (cedricve/kios)"

#cd $DIR
#python uploadrelease.py
