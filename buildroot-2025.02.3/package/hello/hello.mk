################################################################################
# hello.mk - Buildroot package makefile for a custom kernel module
################################################################################

HELLO_VERSION = 1.0
HELLO_SITE = $(TOPDIR)/../hello
HELLO_SITE_METHOD = local
HELLO_LICENSE = GPL-2.0

define HELLO_BUILD_CMDS
    $(MAKE) ARCH=$(KERNEL_ARCH) \
        CROSS_COMPILE=$(TARGET_CROSS) \
        -C $(LINUX_DIR) M=$(@D) modules
endef

define HELLO_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/hello.ko \
        $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/hello.ko
endef

$(eval $(generic-package))
