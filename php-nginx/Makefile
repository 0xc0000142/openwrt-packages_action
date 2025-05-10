# SPDX-License-Identifier: MIT
#
# Copyright (C) 2023-2024 muink <https://github.com/muink>

include $(TOPDIR)/rules.mk

PKG_NAME:=php-nginx
PKG_VERSION:=0.2023.04.26
PKG_RELEASE:=1

PKG_MAINTAINER:=Anya Lin <hukk1996@gmail.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=PHP with Nginx as Webserver
	URL:=https://github.com/muink/openwrt-php-nginx
	DEPENDS:=+luci-nginx +luci-ssl-nginx
	PKGARCH:=all
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/nginx/conf.d
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DATA) ./files/php.locations $(1)/etc/nginx/conf.d/php.locations
	$(INSTALL_BIN) ./files/uci-defaults $(1)/etc/uci-defaults/60_$(PKG_NAME)
endef

define Package/$(PKG_NAME)/conffiles
/etc/nginx/conf.d/php.locations
endef

define Package/$(PKG_NAME)/postinst
endef

define Package/$(PKG_NAME)/prerm
endef


$(eval $(call BuildPackage,$(PKG_NAME)))
