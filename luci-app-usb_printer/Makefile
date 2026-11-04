#
# Copyright (C) 2008-2014 The LuCI Team <luci@lists.subsignal.org>
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=USB Printer Share via TCP/IP
LUCI_DEPENDS:= 
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-usb-printer
PKG_VERSION:=1.0
PKG_RELEASE:=2

define Package/$(PKG_NAME)/config
	select PACKAGE_printer-support
	select PACKAGE_kmod-usb-printer
	select PACKAGE_p910nd
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature

