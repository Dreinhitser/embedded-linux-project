################################################################################
#
# usbutils
#
################################################################################

USBUTILS_VERSION = 018
USBUTILS_SOURCE = usbutils-$(USBUTILS_VERSION).tar.xz
USBUTILS_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/usb/usbutils
USBUTILS_DEPENDENCIES = host-pkgconf libusb udev
USBUTILS_LICENSE = GPL-2.0+ (utils) GPL-2.0 or GPL-3.0 (lsusb.py)
USBUTILS_LICENSE_FILES = LICENSES/GPL-2.0-only.txt LICENSES/GPL-3.0-only.txt

ifeq ($(BR2_PACKAGE_LIBICONV),y)
USBUTILS_DEPENDENCIES += libiconv
USBUTILS_LDFLAGS += -liconv
endif

# Nice lsusb.py script only if there's python 3.x
ifeq ($(BR2_PACKAGE_PYTHON3),)
define USBUTILS_REMOVE_PYTHON
	rm -f $(TARGET_DIR)/usr/bin/lsusb.py
endef

USBUTILS_POST_INSTALL_TARGET_HOOKS += USBUTILS_REMOVE_PYTHON
endif

$(eval $(meson-package))
