#############################################################
#
# Phantomjs
#
#############################################################

PHANTOMJS_VERSION = 1.7.0
PHANTOMJS_SITE = http://github.com/ariya/phantomjs
PHANTOMJS_SITE_METHOD = git
PHANTOMJS_INSTALL_TARGET = YES
PHANTOMJS_DEPENDENCIES = python

define PHANTOMJS_BUILD_CMDS
	(cd $(@D); \
	./build.sh; \
	)
endef 

define PHANTOMJS_INSTALL_TARGET_CMDS
        cp $(@D)/bin/phantomjs $(TARGET_DIR)/usr/bin/phantomjs
endef

$(eval $(generic-package))
