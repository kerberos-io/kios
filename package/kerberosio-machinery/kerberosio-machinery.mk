#############################################################
#
# Kerberos.io - Machinery
#
#############################################################
KERBEROSIO_MACHINERY_VERSION = develop
KERBEROSIO_MACHINERY_SITE = https://github.com/kerberos-io/machinery
KERBEROSIO_MACHINERY_SITE_METHOD = git
KERBEROSIO_MACHINERY_INSTALL_TARGET = YES
KERBEROSIO_DEPENDENCIES = libcurl
KERBEROSIO_MAKE=$(MAKE1)

$(eval $(cmake-package))