# OpenWrt wrapper for wolandmaster/luci-app-rtorrent's prebuilt Lua payload.
# The generator installs this template as the imported package's Makefile.
# Upstream's Makefile builds IPKs directly; none of its deployment targets run.

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-rtorrent
PKG_VERSION:=$(shell sed -n 's/^Version:[[:space:]]*//p' $(CURDIR)/control/control)
PKG_RELEASE:=1

PKG_MAINTAINER:=Sandor Balazsi <sandor.balazsi@gmail.com>
PKG_LICENSE:=GPL-3.0-or-later MIT
PKG_LICENSE_FILES:=LICENSE doc/luci-app-rtorrent_license doc/lua-bencode_license doc/lua-xml-rpc_license

ifeq ($(strip $(PKG_VERSION)),)
  $(error Missing Version in luci-app-rtorrent/control/control)
endif

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-rtorrent
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=rTorrent frontend for LuCI
  URL:=https://github.com/wolandmaster/luci-app-rtorrent
  DEPENDS:=+rtorrent-rpc +luaexpat +luasocket +luasec +luci-compat +luci-lib-httpprotoutils
  PKGARCH:=all
endef

define Package/luci-app-rtorrent/description
  LuCI interface for rTorrent, including torrent management and RSS downloads.
endef

define Package/luci-app-rtorrent/conffiles
/etc/config/rtorrent
endef

define Build/Prepare
	$(INSTALL_DIR) $(PKG_BUILD_DIR)
	$(CP) ./src ./doc ./LICENSE $(PKG_BUILD_DIR)/
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-rtorrent/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_BUILD_DIR)/src/. $(1)/
	$(INSTALL_DIR) $(1)/usr/share/doc/$(PKG_NAME)
	$(CP) $(PKG_BUILD_DIR)/doc/. $(1)/usr/share/doc/$(PKG_NAME)/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/LICENSE $(1)/usr/share/doc/$(PKG_NAME)/LICENSE
endef

# Preserve the backup consumed by src/etc/uci-defaults/rtorrent. Copying instead
# of moving also keeps the live config intact if the package installation fails.
define Package/luci-app-rtorrent/preinst
#!/bin/sh
[ "$${IPKG_NO_SCRIPT}" = "1" ] && exit 0
[ -n "$${IPKG_INSTROOT}" ] && exit 0
if [ -f /etc/config/rtorrent ]; then
	cp -p /etc/config/rtorrent /etc/config/rtorrent-prev || exit 1
fi
exit 0
endef

# package.mk generates the APK/IPK default_postinst/default_prerm integration;
# calling those helpers again here would execute the default hooks twice.
define Package/luci-app-rtorrent/postinst
#!/bin/sh
[ "$${IPKG_NO_SCRIPT}" = "1" ] && exit 0
[ -n "$${IPKG_INSTROOT}" ] && exit 0
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache
exit 0
endef

define Package/luci-app-rtorrent/prerm
#!/bin/sh
[ "$${IPKG_NO_SCRIPT}" = "1" ] && exit 0
[ -n "$${IPKG_INSTROOT}" ] && exit 0
rm -rf /tmp/luci-indexcache* /tmp/luci-modulecache
exit 0
endef

$(eval $(call BuildPackage,luci-app-rtorrent))
