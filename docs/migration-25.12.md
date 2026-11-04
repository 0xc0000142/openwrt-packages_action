# OpenWrt 25.12 软件包迁移说明

25.12 分支以 `packages-21.02.sh` 的全部 **195 条非注释 `git clone` 命令**为来源基线。该数字包含重复获取；可用的独立来源、集合 feed、不可达来源的替代和历史补全都纳入清单。

- [sources-25.12.tsv](../sources-25.12.tsv) 决定实际获取和导入的来源、ref、路径及顺序。
- [sources-25.12-coverage.tsv](../sources-25.12-coverage.tsv) 将旧脚本的获取命令映射到新来源或替代处理，供逐项核对。
- [packages-25.12.sh](../packages-25.12.sh) 根据清单获取源码、识别包目录并生成报告。

## 来源顺序与覆盖范围

2026-11-04 完整生成的报告统计如下；后续上游更新可能改变数量：

| 项目 | 数量与含义 |
| --- | --- |
| 旧调用覆盖 | 195 条获取命令均在覆盖表中说明去向 |
| `SOURCES.lock` | 173 个来源记录；同一仓库的不同 ref 可以有独立记录 |
| `PACKAGES.tsv` | 608 个顶层软件包目录，包含套件和嵌套配方，不等于 608 个 APK |
| 旧快照候选 | 569 个 OpenWrt 候选配方：23 个补全导入，546 个已有优先来源，每个都有记录 |
| 历史检查标签 | 25 个目录：上述 23 个快照补全，加 GoWebDav、bandwidthd 两个历史分支配方 |
| `MIGRATION.tsv` | 608 条导入、813 条重复来源、21 条原有排除、15 条配方适配记录 |

旧快照候选统计按 OpenWrt 配方识别。另一个非标准源码 `luci-app-rtorrent` 已通过显式包装导入，包含在 608 个目录中，避免它因原 Makefile 只会打自制 IPK 而漏掉。

来源按以下优先顺序处理：维护中的替代来源和新增来源、原独立仓库、原集合 feed、固定历史快照。集合 feed 递归识别 OpenWrt Makefile，导入未被前面来源覆盖的包。同一包有多个来源时保留先导入的一份，并记录被选中的来源，避免重复包定义。

最终历史补全使用本仓库 `packages-21.02` 分支的固定提交：

```text
c0ce1126afe2576f28ad720a9840ea3ff5c43b6b
```

该快照对应 2025 年 5 月 15 日的已生成源码，用于保留当前来源未覆盖的既有功能；它无法证明不可达历史上游曾经包含的全部内容都可恢复。

原脚本对 `base-files`、`dnsmasq`、`firewall`、`firewall4`、`fullconenat`、`fullconenat-nft`、`libnftnl`、`nftables`、`opkg`、`ppp`、`wireless-regdb` 和 `plugin-gargoyle*` 的排除继续记录在 `MIGRATION.tsv`。另外显式从 ImmortalWrt 25.12 引入 `package/network/utils/fullconenat`，以 `fullconenat-iptables` 目录保存 iptables 内核扩展配方；这不是替换系统 firewall4，需单独验证内核、iptables 和目标防火墙配置。其余驱动和内核扩展也保留源码及来源记录。

## 逐项地址修复与来源替代

下表中的 ref 和子目录用于说明核实到的来源关系，实际生成采用来源清单中的条目，并在 `SOURCES.lock` 记录本次 commit。

| 原来源或写法 | 修复、替代或补全 | 说明 |
| --- | --- | --- |
| `xiaorouji/openwrt-passwall` | `Openwrt-Passwall/openwrt-passwall` / `main` | 使用当前组织下的 LuCI 包来源。 |
| `xiaorouji/openwrt-passwall-packages` | `Openwrt-Passwall/openwrt-passwall-packages` / `main` | 保留依赖集合 feed 的包范围，递归识别，不限制为少量包名。 |
| `sirpdboy/sirpdboy-package` | 当前独立来源、原集合 feed，以及固定旧输出快照补全 | 原地址不可用，不能简单把其历史功能全部删掉；每个最终包的来源由报告记录。 |
| `krystic/luci-app-cifs-mount` | `immortalwrt/luci` / `openwrt-25.12` / `applications/luci-app-cifs-mount` | 当前包提供 SMB/CIFS 挂载功能，并声明提供 `luci-app-cifs`；其他同名来源参与去重。 |
| `chinaboy2345/luci-app-ramfree` | `immortalwrt/luci` / `openwrt-25.12` / `applications/luci-app-ramfree` | 原集合 feed 内的 RAM free 副本也纳入重复来源核对。 |
| `jarod360/luci-app-xupnpd` | 固定旧输出快照中的 `luci-app-xupnpd` | 保留 LuCI 功能源码；其 `xupnpd` 依赖在官方 25.12 packages feed 的 `multimedia/xupnpd` 中仍有配方。旧 LuCI 界面仍需移植验证。 |
| `immortalwrt-collections/openwrt-gowebdav` | `immortalwrt/packages` / `openwrt-21.02` / `net/gowebdav` | 优先采用同一原实现的历史配方；界面由其他保留来源及快照补全。保留原实现，不仅凭相同包名替换服务。 |
| `2lambda123/openwrt-chinadns` | `aa65535/openwrt-chinadns` / `master` | 保留原 ChinaDNS 功能；它与 ChinaDNS-NG 是不同来源，不能因后者存在就省略前者。 |
| `brvphoenix/wrtbwmon/wrtbwmon` | 仓库 `brvphoenix/wrtbwmon` / `master`，子目录 `wrtbwmon` | 修复把子目录写进 clone URL 的错误，保留流量监控包。 |
| `0xcFFFF142/luci-app-pcap-dnsproxy/./luci-app-pcap-dnsproxy` | 仓库 `0xcFFFF142/luci-app-pcap-dnsproxy` / `app`，仓库根目录 | `app` 分支和配方有效；与其他 Pcap_DNSProxy 界面来源的取舍需记录，不能当作整个功能失效。 |
| 重复的 Argon、RAM free、CIFS、wrtbwmon 等来源 | 按来源顺序选择唯一包定义 | 重复获取不是新增功能；覆盖表保留旧调用关系，迁移报告保留未选中的来源及原因。 |

GoWebDav 保留 `1715173329/gowebdav` 实现；某些同名配方使用 `hacdias/webdav`，配置和服务接口不同，不直接替换。

## Alist、OpenList2 与 Argon 配置

`sbwml/luci-app-alist` 继续提供 Alist；新增 `sbwml/luci-app-openlist2` / `main` 的 `openlist2` 和 `luci-app-openlist2`，不会自动替换现有 Alist 服务。

Argon 3.0 已把配置页、背景和相关服务集成到 `luci-theme-argon`。`jerrykuku/luci-app-argon-config` 当前 `master` 提供沿用旧包名的空兼容迁移包，不再是旧版独立配置插件。生成器须识别主题内嵌的包定义，并与独立仓库中的同名定义去重，保留完整主题配置功能及唯一的兼容包定义。旧 1.0 配置插件不能与 3.0 集成主题一同安装，否则可能覆盖同一批文件。

## 非标准源码仓库与包装配方

旧脚本中的 `git clone` 目标不全是可直接编译的 OpenWrt 包：有的仓库只含上游程序源码，有的包位于二级目录，还有的配方把其他包嵌在自己的目录下。因此不能仅按克隆目录数计算功能覆盖。

| 原来源 | 采用的包装来源 | 保留的功能与检查要求 |
| --- | --- | --- |
| `pyrovski/wrtbwmon` | `brvphoenix/wrtbwmon` 中的 OpenWrt 配方 | 原仓库使用独立 IPK 构建结构，改由 OpenWrt 配方提供流量统计程序。 |
| `Kiougar/luci-wrtbwmon` | `brvphoenix/luci-app-wrtbwmon` | 保留流量统计 LuCI 界面，检查其与选中的后端版本是否匹配。 |
| `starsunyzl/ddns-scripts-dnspod` | `kenzok8/small-package` 中的 DDNS 配方，并由固定快照补全 | 原脚本集合通过 OpenWrt 包提供 DNSPod 更新功能，保留来源映射。 |
| `padre-lacroix/bandwidthd-openwrt` | `openwrt/packages` / `openwrt-21.02` / `utils/bandwidthd` | 官方新分支已移除此包；保留历史包装配方及带宽统计功能，标记待移植检查。 |
| `kenzok8/small-package/luci-app-rtorrent` | 本仓库的 `packages-25.12-overrides/luci-app-rtorrent.mk` | 显式导入全部 `src/`，保留 LICENSE、doc 许可证、配置和依赖；由标准 OpenWrt 包规则生成安装钩子及 APK。 |

`luci-app-rtorrent` 当前包装版本为 `0.2.3-r1`，版本号从上游 control 文件读取。安装前复制现有配置供原 UCI 默认脚本恢复，保留缓存清理并保护离线安装；不运行上游 `test-deploy`，也不重复调用 SDK 已提供的默认钩子。已验证 SDK 元数据解析、103 个载荷文件的内容与权限、许可证和钩子保护，并以 `NO_DEPS=1` 实际构建包装 APK；该测试未构建 rTorrent 核心及完整依赖链。

## 配方和依赖适配

- EasyTier 按 `easytier-suite` 套件导入，保留内嵌配方的相对目录关系，避免拆平后丢失公共文件或产生重复包定义。
- 补充 `libcryptopp`（ImmortalWrt 25.12）、`dogcom`（`mchome/openwrt-dogcom`）、`urllogger`（`x-wrt/com.x-wrt`）及 `luci-app-mini-diskmanager`（`4IceG`）来源；优先采用当前 `fw876/helloworld` 的 Shadowsocks-libev 拆包配方和官方 25.12 `net/vsftpd`，旧定义进入去重记录。
- 迁移 LuCI 与 Go 配方后，将相对 `luci.mk` 和 `golang-package.mk` 引用改为目标源码树的官方 feed 路径。
- `luci-app-shadowsocks` 的旧 `po2lmo/host` 构建依赖改为 `luci-base/host`；qBittorrent 的 Qt5 依赖改为 `qt5base-*`、`qt5tools`。
- DAE/DAED 的旧 geodata 依赖名改为 `v2ray-geoip`、`v2ray-geosite`；修正 easyconfig 的 Make/awk 美元符转义，移除 USB 打印界面引用的失效 `PACKAGE_printer-support` 选择项。

这些更改记录为 `adapted`，用于修复已识别的配方问题；依赖索引检查和实际构建仍分别验证。

## 保留源码的待移植项

以下来源仍引用当前 25.12 检查环境未提供的旧依赖，源码全部保留。条件依赖仅在启用对应选项时生效；某个变体缺依赖不表示同一源码下的全部变体都不可用。

| 源码目录 | 仍需检查的依赖或选项 |
| --- | --- |
| `bandwidthd` | `bandwidthd-sqlite`、`bandwidthd-php` 变体引用 `php7` 及其模块；PHP 变体还引用 `libpcre`。 |
| `luci-app-nginx-pingos` | 引用旧 `libpcre`。 |
| `luci-app-samba` | 依赖 `samba36-server`，需要核对新版 Samba 服务和配置接口。 |
| `luci-app-turboacc` | 可选加速项引用 `kmod-fast-classifier`、`kmod-shortcut-fe-cm`、`kmod-shortcut-fe-drv`、`kmod-nft-fullcone`。 |
| `luci-app-vssr-plus` | 基础依赖 `shadowsocksr-libev-alt`；可选项还引用旧 `kcptun`、`shadowsocksr-libev-server`、`chinadns`、`gq-client`、`gq-server` 名称。 |
| `trojan`、`trojan-plus` | 引用旧 `boost-system` 包名，需要结合当前 Boost 接口验证。 |

## 生成报告与验证边界

每次成功生成会附带以下文件：

| 文件 | 用途 |
| --- | --- |
| `SOURCES.lock` | 记录获取的来源 ID、URL、ref 和实际 commit，便于复现与追查。 |
| `PACKAGES.tsv` | 记录导入包的名称、来源、原始路径和 `review` 标签。 |
| `MIGRATION.tsv` | 记录导入、重复包选择、原有排除和历史补全，解释每个候选包的处理。 |

`not-build-tested` 表示尚未逐包完成构建验证；快照补全和历史分支配方标记 `legacy-fallback-needs-porting-review`，需要移植检查。

2026-11-04 在 OpenWrt 25.12.5 SDK 对最终生成结果完成索引检查：**612 个源码配方、1243 个二进制包定义、4037 个运行依赖引用**。索引错误、feed 内部重复定义、缺失构建依赖和缺失 Kconfig 选择项均为 0；mini-diskmanager 及其波兰语翻译均已进入索引。运行依赖仍有上表 7 个源码目录的待移植项，索引检查只验证当前来源中的元数据可用性。

实际 APK 构建覆盖 **Argon** 及以 `NO_DEPS=1` 构建的 **luci-app-rtorrent 包装**。没有完成全部软件包、全部架构的编译、安装或运行测试；工作流只整理源码，不编译固件。

使用时保留官方 25.12 feeds，按目标架构选包并检查依赖和 `review` 标签。运行仓库的离线生成测试需切换到 `master` 开发分支；软件包发布分支不附带 `tests/`。
