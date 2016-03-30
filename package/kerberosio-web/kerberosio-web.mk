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
        php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '41e71d86b40f28e771d4bb662b997f79625196afcca95a5abf44391188c695c6c1456e16154c75a211d238cc3bc5cb47') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" ; \
        php composer-setup.php; \
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
    ln -s /data/www/ $(TARGET_DIR)/var/www/web/app/storage
    
    # enable memcached
    cat $(TARGET_DIR)/etc/php.ini | grep -q extension=memcached.so || echo "extension=memcached.so" >> $(TARGET_DIR)/etc/php.ini
    
endef 

$(eval $(generic-package))