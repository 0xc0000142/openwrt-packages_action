# SPDX-License-Identifier: Apache-2.0
#
# Copyright (C) 2023 ImmortalWrt.org

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI app for dae dashboard
LUCI_DEPENDS:=+daed +v2ray-geoip +v2ray-geosite
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
