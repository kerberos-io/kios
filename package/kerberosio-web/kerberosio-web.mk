#############################################################
#
# Kerberos.io - Web
#
#############################################################

KERBEROSIO_WEB_VERSION = develop
KERBEROSIO_WEB_SITE = https://github.com/kerberos-io/web
KERBEROSIO_WEB_SITE_METHOD = git
KERBEROSIO_WEB_INSTALL_TARGET = YES
KERBEROSIO_WEB_DEPENDENCIES = kerberosio-machinery nginx php

##########################################################################
#
# The configuration requires to have PHP (+ curl and mcrypt extension) and 
# nodejs/bower installed on the build machine.
#

define KERBEROSIO_WEB_BUILD_CMDS
    (cd $(@D); \
        php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php; \
        php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '7228c001f88bee97506740ef0888240bd8a760b046ee16db8f4095c0d8d525f2367663f22a46b48d072c816e7fe19959') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"; \
        php composer-setup.php; \
        php -r "unlink('composer-setup.php');"; \
        php composer.phar install; \
        cd public; \
        bower install --allow-root; \
    )
endef 

##########################################################################
#
# Copy the whole build directory to /var/www
#

define KERBEROSIO_WEB_INSTALL_TARGET_CMDS
    
    rm -rf $(TARGET_DIR)/var/www/web
    mkdir -p $(TARGET_DIR)/var/www/web
    cp -R $(@D)/* $(TARGET_DIR)/var/www/web
    sed -i "s#__DIR__.'/../app'#'/data/web'#g" $(TARGET_DIR)/var/www/web/bootstrap/paths.php 
    sed -i "s#__DIR__.'/../app/storage'#'/data/web/storage'#g" $(TARGET_DIR)/var/www/web/bootstrap/paths.php
    
    # enable memcached
    cat $(TARGET_DIR)/etc/php.ini | grep -q extension=memcached.so || echo "extension=memcached.so" >> $(TARGET_DIR)/etc/php.ini
    
endef 

$(eval $(generic-package))