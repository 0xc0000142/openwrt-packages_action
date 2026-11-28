include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI support for KodExplorer
LUCI_PKGARCH:=all
PKG_VERSION:=1
PKG_RELEASE:=1

LUCI_DEPENDS:= \
	+nginx 
    +unzip    
    +zoneinfo-asia    
    +php8
    +php8-cgi
    +php8-fpm
    +php8-mod-curl
    +php8-mod-dom
    +php8-mod-exif
    +php8-mod-fileinfo
    +php8-mod-filter
    +php8-mod-ftp
    +php8-mod-gd
    +php8-mod-gettext
    +php8-mod-iconv
    +php8-mod-intl
    +php8-mod-ldap
    +php8-mod-mbstring
    +php8-mod-mysqli
    +php8-mod-mysqlnd
    +php8-mod-opcache
    +php8-mod-openssl
    +php8-mod-pdo
    +php8-mod-pdo-mysql
    +php8-mod-pdo-sqlite
    +php8-mod-session
    +php8-mod-simplexml
    +php8-mod-sockets
    +php8-mod-sqlite3
    +php8-mod-xml
    +php8-mod-zip
    +php8-pecl-imagick
    +php8-pecl-mcrypt
    +php8-pecl-redis

include $(TOPDIR)/feeds/luci/luci.mk

define Package/luci-app-kodexplorer
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=Applications
  TITLE:=$(LUCI_TITLE)
  DEPENDS:=$(LUCI_DEPENDS)
  PKGARCH:=$(LUCI_PKGARCH)
endef

$(eval $(call BuildPackage,luci-app-kodexplorer))
