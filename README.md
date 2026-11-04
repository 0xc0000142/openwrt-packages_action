# openwrt-packages
国内常用OpenWrt软件包源码合集，通过 GitHub Actions 更新。

OpenWrt 25.12 请使用 `packages-25.12` 分支，由 `packages-25.12.sh` 按 `sources-25.12.tsv` 生成。以 `packages-21.02.sh` 的全部 195 条源码获取命令为迁移基线，保留可用的独立来源和集合 feed，并为失效来源补充替代或固定历史源码。

18.06 版 LuCI 请使用 `packages` 分支（历史版本，已停止维护）。

19.07 版 LuCI 请使用 `packages-19.07` 分支（历史版本）。

21.\* 版 LuCI 请使用 `packages-21.02` 分支（历史版本）。

历史版本的旧获取链路仍包含失效来源，不能保证更新脚本和生成的软件包可用。

### 25.12 软件包范围

| 优先顺序 | 来源 | 导入方式 |
| --- | --- | --- |
| 1 | 维护中的替代来源和新增来源 | 修复迁移地址；CIFS、RAM free 使用 ImmortalWrt 25.12 来源；新增 OpenList2，保留 Alist |
| 2 | 原脚本中的可用独立仓库 | 保留原有功能，识别仓库根目录或子目录中的 OpenWrt 包 |
| 3 | 原脚本中的集合 feed | 递归识别包目录，导入未被更高优先级来源提供的包 |
| 4 | 原 `packages-21.02` 固定快照 | 补全前面来源未覆盖的既有包，标记为历史源码，等待移植检查 |

2026-11-04 完整生成读取 **173 个来源记录，输出 608 个顶层软件包目录**，其中 23 个由固定旧快照补全。旧快照的 569 个 OpenWrt 候选配方均有导入或重复来源记录；另外保留了原本使用自制 IPK 构建方式的 `luci-app-rtorrent`。目录可能包含多个配方，因此目录数不等于最终 APK 数量。

195 是旧脚本的获取命令数，包含重复仓库。同名包按来源顺序保留首个定义，逐项覆盖及处理结果见 [25.12 迁移说明](docs/migration-25.12.md)、[来源清单](sources-25.12.tsv) 和 [旧来源覆盖表](sources-25.12-coverage.tsv)。

请保留 OpenWrt 25.12 对应的官方 `packages`、`luci` 等 feeds。本仓库沿用基础系统包的排除规则，同时保留驱动及内核扩展源码；显式引入的 `fullconenat-iptables` 是 iptables 的扩展配方，不替换系统 firewall4，仍需检查目标内核和防火墙配置的兼容性。每次生成同时输出：

- `SOURCES.lock`：每个上游的地址、分支或固定提交，以及实际使用的 commit。
- `PACKAGES.tsv`：包的归属来源、原始路径和 `review` 检查标签。
- `MIGRATION.tsv`：导入、去重、排除及历史补全的逐项记录。

OpenWrt 25.12.5 SDK 已解析 **612 个源码配方、1243 个二进制包定义**，无索引错误或 feed 内部重复定义；仍有 7 个源码目录引用旧运行依赖，详见迁移说明。Argon APK 已实际构建，`luci-app-rtorrent` 包装也以 `NO_DEPS=1` 构建 APK；后者未验证 rTorrent 核心及完整依赖构建。其余包按 `review` 标签检查，这些结果不代表全量编译或运行验证通过。

### 常用源码
| 提供者 | 名称 | 版本说明 | 地址 |
| --- | -- | ------ | -- |
| OpenWrt Official | OpenWrt 官方源 | 25.12 请使用对应版本源码 |[https://github.com/openwrt/openwrt](https://github.com/openwrt/openwrt) |
| ImmortalWRT(China) | ImmortalWRT | 以项目分支说明为准 | [https://github.com/immortalwrt/immortalwrt](https://github.com/immortalwrt/immortalwrt)|
| Lean | Lean 源码 | 以项目分支说明为准 |  [https://github.com/coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)|
| X-wrt | X-wrt | 以项目分支说明为准 | [https://github.com/x-wrt/x-wrt](https://github.com/x-wrt/x-wrt)|

## 食用方式（二选一，这里以25.12为例）：

如果目标分支尚不存在，请先按下方“手动更新”运行对应任务；首次成功运行会自动创建发布分支。

还是建议按需取用，不然碰到依赖问题不太好解决。驱动等与内核有关的软件包，还需要检查目标内核和架构是否兼容。

1. 先cd进package目录，然后执行

+ 25.12 `git clone -b packages-25.12 https://github.com/0xc0000142/openwrt-packages_action.git`
+ 21.02 `git clone -b packages-21.02 https://github.com/0xc0000142/openwrt-packages_action.git`
+ 19.07 `git clone -b packages-19.07 https://github.com/0xc0000142/openwrt-packages_action.git`
+ 18.06 `git clone -b packages https://github.com/0xc0000142/openwrt-packages_action.git`

2. 或者添加下面代码到feeds.conf.default文件

+ 25.12 `src-git 0xc0000142_packages https://github.com/0xc0000142/openwrt-packages_action.git;packages-25.12`
+ 21.02 `src-git 0xc0000142_packages https://github.com/0xc0000142/openwrt-packages_action.git;packages-21.02`
+ 19.07 `src-git 0xc0000142_packages https://github.com/0xc0000142/openwrt-packages_action.git;packages-19.07`
+ 18.06 `src-git 0xc0000142_packages https://github.com/0xc0000142/openwrt-packages_action.git;packages`

添加 feed 后，在 OpenWrt 源码根目录执行 `./scripts/feeds update -a`，再使用 `./scripts/feeds install -p 0xc0000142_packages <包名>` 按需安装。`-p` 明确优先使用本 feed 的同名软件包，避免来源顺序不明确。

## 手动更新

1. 确认 `.github/workflows/update-packages.yml` 已提交到 GitHub 仓库的默认分支。如果 GitHub 已停用该工作流，请先点击 **Enable workflow**。
2. 打开仓库的 **Actions → Update packages → Run workflow**。
3. 在 `target` 中选择目标：默认是 `packages-25.12`；也可选择一个历史版本，或选择 `all` 同时运行全部目标。历史版本仍有失效来源，选择 `all` 不代表这些版本已经修复。
4. 点击 **Run workflow** 开始更新，查看各步骤日志；首次成功运行会自动创建对应发布分支，例如 `packages-25.12`。

工作流用于整理并发布软件包源码，不执行固件编译。25.12 的实际来源以 `sources-25.12.tsv` 为准，包级结果请查看发布分支的 `PACKAGES.tsv` 和 `MIGRATION.tsv`。

生成在临时目录内完成，下载失败或必需的包目录缺失会停止发布；没有内容变化则正常结束。自动触发仍运行全部版本，历史版本的失败不会阻止 25.12 任务单独完成。

## 本地生成与检查

在安装了 Bash、Git 和常用 GNU 工具的环境中，进入本仓库的 **`master` 开发分支**后执行。发布分支用于提供软件包，不包含 `tests/`：

```bash
git switch master

# 输出目录必须不存在或为空，避免覆盖现有源码。
bash packages-25.12.sh /tmp/packages-25.12

# 离线检查成功生成、下载失败、目录变化和覆盖保护。
bash tests/test-packages-25.12.sh
```

## 不要为了下载而Fork这个项目
