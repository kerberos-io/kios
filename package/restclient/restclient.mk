################################################################################
#
# restclient
#
################################################################################

RESTCLIENT_VERSION = b9ac3c8a8487927717596ac492eaa1366e152e87
RESTCLIENT_SITE = https://github.com/cedricve/restclient-cpp
RESTCLIENT_SITE_METHOD = git
RESTCLIENT_INSTALL_TARGET = YES
RESTCLIENT_AUTORECONF = YES
RESTCLIENT_CONF_OPTS += --enable-static

$(eval $(autotools-package))
$(eval $(host-autotools-package))
