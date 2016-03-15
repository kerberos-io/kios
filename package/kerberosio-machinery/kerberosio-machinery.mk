############################################################
#
# Kerberos.io - Machinery
#
#############################################################

KERBEROSIO_MACHINERY_VERSION = develop
KERBEROSIO_MACHINERY_SITE = https://github.com/kerberos-io/machinery
KERBEROSIO_MACHINERY_SITE_METHOD = git
KERBEROSIO_MACHINERY_INSTALL_TARGET = YES
KERBEROSIO_MACHINERY_DEPENDENCIES = libcurl ffmpeg eigen
KERBEROSIO_MACHINERY_MAKE=$(MAKE1)

define KERBEROSIO_MACHINERY_BIND_DIRS_TO_DATA

	# Link capture directory to data folder
	rm -rf $(TARGET_DIR)/etc/opt/kerberosio/capture
	ln -s /data/media $(TARGET_DIR)/etc/opt/kerberosio/capture 

endef

KERBEROSIO_MACHINERY_POST_INSTALL_TARGET_HOOKS += KERBEROSIO_MACHINERY_BIND_DIRS_TO_DATA

$(eval $(cmake-package))
