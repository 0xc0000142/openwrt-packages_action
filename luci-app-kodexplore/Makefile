include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI support for KodExplorer

# 核心依赖（保证菜单可见）
LUCI_DEPENDS:= \
	+php8 \
	+php8-cgi \
	+php8-fpm \
	+nginx

# 可选依赖（不会影响菜单显示）
LUCI_DEPENDS+= \
	+PACKAGE_php8-mod-curl:php8-mod-curl \
	+PACKAGE_php8-mod-dom:php8-mod-dom \
	+PACKAGE_php8-mod-fileinfo:php8-mod-fileinfo \
	+PACKAGE_php8-mod-gd:php8-mod-gd \
	+PACKAGE_php8-mod-iconv:php8-mod-iconv \
	+PACKAGE_php8-mod-intl:php8-mod-intl \
	+PACKAGE_php8-mod-mbstring:php8-mod-mbstring \
	+PACKAGE_php8-mod-opcache:php8-mod-opcache \
	+PACKAGE_php8-mod-openssl:php8-mod-openssl \
	+PACKAGE_php8-mod-pdo:php8-mod-pdo \
	+PACKAGE_php8-mod-pdo-sqlite:php8-mod-pdo-sqlite \
	+PACKAGE_php8-mod-session:php8-mod-session \
	+PACKAGE_php8-mod-xml:php8-mod-xml \
	+PACKAGE_php8-mod-zip:php8-mod-zip

LUCI_PKGARCH:=all
PKG_VERSION:=1
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk

define Package/luci-app-kodexplorer
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=Applications
  TITLE:=$(LUCI_TITLE)
  DEPENDS:=$(LUCI_DEPENDS)
  PKGARCH:=$(LUCI_PKGARCH)
endef

define Package/luci-app-kodexplorer/description
 LuCI support for KodExplorer, a web-based file manager for OpenWrt.
endef

$(eval $(call BuildPackage,luci-app-kodexplorer))
