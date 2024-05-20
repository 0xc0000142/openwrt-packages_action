include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-poddns
PKG_VERSION:=0.0.2
PKG_RELEASE:=1

LUCI_TITLE:=LuCI Support for poddns
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+luci-compat +curl +jsonfilter

define Package/$(PKG_NAME)/conffiles
/etc/config/poddns
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
