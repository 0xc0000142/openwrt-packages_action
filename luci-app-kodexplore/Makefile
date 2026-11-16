include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI support for KodExplorer
LUCI_PKGARCH:=all
PKG_VERSION:=1
PKG_RELEASE:=1

# ============================================================
# 核心运行时
# ============================================================
LUCI_DEPENDS:= \
	+nginx \
	+php8 \
	+php8-fpm

# ============================================================
# KodExplorer 文档列出的必需扩展（全部强制安装）
# 注意：php-libxml 和 php-zlib 由 php8 主包覆盖，无独立 mod 包
# ============================================================
LUCI_DEPENDS+= \
	+php8-mod-curl \
	+php8-mod-dom \
	+php8-mod-gd \
	+php8-mod-json \
	+php8-mod-mbstring \
	+php8-mod-openssl \
	+php8-mod-session \
	+php8-mod-xml \
	+php8-mod-zip

# ============================================================
# 建议扩展（全部强制安装）
# ============================================================
LUCI_DEPENDS+= \
	+php8-mod-intl \
	+php8-mod-exif

# ============================================================
# 数据库扩展（全部强制安装，覆盖 MySQL/MariaDB 两种连接方式）
# SQLite 仍建议仅作测试，但 pdo-sqlite 一并安装以保持完整性
# ============================================================
LUCI_DEPENDS+= \
	+php8-mod-pdo \
	+php8-mod-pdo-mysql \
	+php8-mod-mysqli \
	+php8-mod-pdo-sqlite

# ============================================================
# 指定功能扩展（全部强制安装）
# ============================================================
LUCI_DEPENDS+= \
	+php8-mod-ldap \
	+php8-mod-ftp

# ============================================================
# 性能/缓存扩展（全部强制安装）
# Redis 使用 php8-pecl-redis，不是 php8-mod-redis
# Memcached 在 OpenWrt 官方源中无 PHP8 扩展包，无法通过依赖安装
# ============================================================
LUCI_DEPENDS+= \
	+php8-pecl-redis

# ============================================================
# 其他常用且实际存在的 PHP8 扩展（按“全部安装”原则一并加入）
# 这些不是 KodExplorer 强制要求，但属于 PHP8 在 OpenWrt 上常见的可用模块
# ============================================================
LUCI_DEPENDS+= \
	+php8-mod-fileinfo \
	+php8-mod-iconv \
	+php8-mod-opcache \
	+php8-mod-ctype \
	+php8-mod-phar \
	+php8-mod-simplexml \
	+php8-mod-xmlwriter \
	+php8-mod-xmlreader

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
 LuCI support for KodExplorer on OpenWrt 25.12.
 All available PHP8 extensions required and recommended by KodExplorer
 are installed as hard dependencies, with the exception of Memcached
 (no official php8 extension package exists in the OpenWrt feed).
 Memcached support must be added manually if needed.
endef

define Package/luci-app-kodexplorer/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/kodexplorer.init $(1)/etc/init.d/kodexplorer
	chmod 0755 $(1)/etc/init.d/kodexplorer

	# KodExplorer 运行时目录（按你的 init 脚本实际路径调整）
	$(INSTALL_DIR) $(1)/tmp/kodexplorer
endef

$(eval $(call BuildPackage,luci-app-kodexplorer))