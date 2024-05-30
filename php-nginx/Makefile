#
# Copyright (C) 2023 muink
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=php-nginx
PKG_VERSION:=20230426
#PKG_RELEASE:=

PKG_MAINTAINER:=muink <hukk1996@gmail.com>
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
