############################################################
#
# Kerberos.io - Machinery
#
#############################################################

KERBEROSIO_MACHINERY_VERSION = develop
KERBEROSIO_MACHINERY_SITE = https://github.com/kerberos-io/machinery
KERBEROSIO_MACHINERY_SITE_METHOD = git
KERBEROSIO_MACHINERY_INSTALL_TARGET = YES
KERBEROSIO_MACHINERY_DEPENDENCIES = libcurl ffmpeg eigen libpng restclient
ifeq ($(BR2_PACKAGE_KERBEROSIO_MACHINERY_RPI),y)
	KERBEROSIO_MACHINERY_DEPENDENCIES += rpi-firmware rpi-userland
endif

KERBEROSIO_MACHINERY_MAKE=$(MAKE1) -j10

define KERBEROSIO_MACHINERY_REMOVE_INSTALL_DIR

    rm -rf $(TARGET_DIR)/etc/opt/kerberosio/

endef

KERBEROSIO_MACHINERY_PRE_INSTALL_TARGET_HOOKS += KERBEROSIO_MACHINERY_REMOVE_INSTALL_DIR

define KERBEROSIO_MACHINERY_BIND_DIRS_TO_DATA

    #create .deb package
    (cd $(@D); \
        $(HOST_DIR)/usr/bin/cpack --config ../../../../package/kerberosio-machinery/CPackConfig.cmake -D CPACK_INSTALL_CMAKE_PROJECTS="$(@D);kerberosio;ALL;/"; \
    )

	# Link directories to data folder
	rm -rf $(TARGET_DIR)/etc/opt/kerberosio/capture
	ln -s /data/machinery/capture $(TARGET_DIR)/etc/opt/kerberosio/capture
  rm -rf $(TARGET_DIR)/etc/opt/kerberosio/logs
  ln -s /data/machinery/logs $(TARGET_DIR)/etc/opt/kerberosio/logs
  rm -rf $(TARGET_DIR)/etc/opt/kerberosio/symbols
  ln -s /data/machinery/symbols $(TARGET_DIR)/etc/opt/kerberosio/symbols
  rm -rf $(TARGET_DIR)/etc/opt/kerberosio/h264
  ln -s /data/machinery/h264 $(TARGET_DIR)/etc/opt/kerberosio/h264

endef

KERBEROSIO_MACHINERY_POST_INSTALL_TARGET_HOOKS += KERBEROSIO_MACHINERY_BIND_DIRS_TO_DATA

$(eval $(cmake-package))
