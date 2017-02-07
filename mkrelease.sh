#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)";

echo "Compiling Kerberos.io for each board"

rm -rf $DIR/kios-*
rm -rf $DIR/.download/kerberosio-*
rm -rf $DIR/output/raspberrypi/build/kerberosio-*
rm -rf $DIR/output/raspberrypi2/build/kerberosio-*
rm -rf $DIR/output/raspberrypi3/build/kerberosio-*

$DIR/build.sh all # should be all..
$DIR/build.sh all mkrelease

echo "Creating Kerberos.io releases per board"

mkdir -p $DIR/releases
DATE=$(date +%Y%m%d)

echo "Preparing release for Raspberry Pi board"

mkdir -p $DIR/releases/rpi/$DATE
cp $DIR/kios-raspberrypi-* $DIR/releases/rpi/$DATE
for file in $DIR/output/raspberrypi/build/kerberosio-machinery*/kerberosio*; do cp -v -- "$file" "$DIR/releases/rpi/$DATE/rpi1-machinery-${file##*/}"; done
cd $DIR/output/raspberrypi/target/var/www/web && rm -rf app/storage && mkdir -p app/storage/cache && mkdir -p app/storage/logs && mkdir -p app/storage/meta && mkdir -p app/storage/sessions && mkdir -p app/storage/views && sed -i 's/memcached/lockfile/g' app/config/session.php && sed -i 's/\/data\/machinery\/config/\/\etc\/opt\/kerberosio\/config/g' app/config/app.php && sed -i "s#'/data/web/app/config'#\$this\['path'\] . '/config'#g" bootstrap/compiled.php && sed -i "s#'/data/web/app/storage'#__DIR__.'/../app/storage'#g" bootstrap/paths.php && sed -i "s#'/data/web/app/config'#app_path() . '/config'#g" app/controllers/UserController.php && sed -i "s#'/data/web/app/config'#app_path() . '/config'#g" app/controllers/SettingsController.php && tar czf $DIR/releases/rpi/$DATE/web.tar.gz .

echo "Preparing release for Raspberry Pi2 board"

mkdir -p $DIR/releases/rpi2/$DATE
cp $DIR/kios-raspberrypi2-* $DIR/releases/rpi2/$DATE
for file in $DIR/output/raspberrypi2/build/kerberosio-machinery*/kerberosio*; do cp -v -- "$file" "$DIR/releases/rpi2/$DATE/rpi2-machinery-${file##*/}"; done
cd $DIR/output/raspberrypi2/target/var/www/web && rm -rf app/storage && mkdir -p app/storage/cache && mkdir -p app/storage/logs && mkdir -p app/storage/meta && mkdir -p app/storage/sessions && mkdir -p app/storage/views && sed -i 's/memcached/lockfile/g' app/config/session.php  && sed -i 's/\/data\/machinery\/config/\/\etc\/opt\/kerberosio\/config/g' app/config/app.php && sed -i "s#'/data/web/app/config'#\$this\['path'\] . '/config'#g" bootstrap/compiled.php && sed -i "s#'/data/web/app/storage'#__DIR__.'/../app/storage'#g" bootstrap/paths.php && sed -i "s#'/data/web/app/config'#app_path() . '/config'#g" app/controllers/UserController.php && sed -i "s#'/data/web/app/config'#app_path() . '/config'#g" app/controllers/SettingsController.php && tar czf $DIR/releases/rpi2/$DATE/web.tar.gz .

echo "Preparing release for Raspberry Pi3 board"

mkdir -p $DIR/releases/rpi3/$DATE
cp $DIR/kios-raspberrypi3-* $DIR/releases/rpi3/$DATE
for file in $DIR/output/raspberrypi3/build/kerberosio-machinery*/kerberosio*; do cp -v -- "$file" "$DIR/releases/rpi3/$DATE/rpi3-machinery-${file##*/}"; done
cd $DIR/output/raspberrypi3/target/var/www/web && rm -rf app/storage && mkdir -p app/storage/cache && mkdir -p app/storage/logs && mkdir -p app/storage/meta && mkdir -p app/storage/sessions && mkdir -p app/storage/views && sed -i 's/memcached/lockfile/g' app/config/session.php && sed -i 's/\/data\/machinery\/config/\/\etc\/opt\/kerberosio\/config/g' app/config/app.php && sed -i "s#'/data/web/app/config'#\$this\['path'\] . '/config'#g" bootstrap/compiled.php && sed -i "s#'/data/web/app/storage'#__DIR__.'/../app/storage'#g" bootstrap/paths.php && sed -i "s#'/data/web/app/config'#app_path() . '/config'#g" app/controllers/UserController.php && sed -i "s#'/data/web/app/config'#app_path() . '/config'#g" app/controllers/SettingsController.php && tar czf $DIR/releases/rpi3/$DATE/web.tar.gz .