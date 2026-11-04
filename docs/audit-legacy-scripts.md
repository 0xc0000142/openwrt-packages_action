# 历史脚本失效内容审计

检查日期：2026-11-04。范围是 `packages.sh`、`packages-19.07.sh`、`packages-21.02.sh` 及更新工作流；网络结果表示检查时的公开访问状态，不等于仓库永久删除。本次新增 25.12 迁移没有修改三个历史生成脚本。

| 已确认的问题 | 位置与影响 |
| --- | --- |
| GitHub SVN 服务已关闭，仍有 **215 条有效 SVN 命令** | [packages.sh:2](../packages.sh#L2) 所在脚本 87 条，[packages-19.07.sh:3](../packages-19.07.sh#L3) 所在脚本 128 条；21.02 的 3 条 SVN 行已注释，不计入。GitHub 于 2024-01-08 宣布[取消 Subversion 支持](https://github.blog/changelog/2024-01-08-subversion-has-been-sunset/)，安装 `subversion` 不能恢复这些 URL。 |
| 三个旧脚本会掩盖中途失败 | 脚本自身未启用失败退出，结尾分别为 [packages.sh:116](../packages.sh#L116)、[packages-19.07.sh:232](../packages-19.07.sh#L232)、[packages-21.02.sh:280](../packages-21.02.sh#L280) 的 `exit 0`。直接执行时，下载或移动失败仍可能返回成功；父 shell 的 `bash -e` 不会自动传给直接执行的 Bash 子脚本。 |
| 19.07 包含未定义命令与拼写错误 | [packages-19.07.sh:20](../packages-19.07.sh#L20) 起共 13 次 `mvdir`，仓库没有定义该函数，也未安装对应工具；[第 30 行](../packages-19.07.sh#L30) 把 `my-packages` 当命令；[第 84 行](../packages-19.07.sh#L84) 将 `trunk` 写成 `tunk`。 |
| 21.02 有 **30 次重复目标目录的 clone 调用** | 将显式目标、默认仓库名、`.git` 后缀和 `./` 规范化后统计；并非 30 个相同 URL。例如 `luci-app-argon-config` 出现在 [第 5 行](../packages-21.02.sh#L5)、第 53 行、第 153 行。前一次成功后，后续 clone 会因目标非空失败。 |
| 两个 clone URL 把包目录拼进仓库地址 | [packages-21.02.sh:172](../packages-21.02.sh#L172) 的 `brvphoenix/wrtbwmon/wrtbwmon`、[第 179 行](../packages-21.02.sh#L179) 的 `0xcFFFF142/luci-app-pcap-dnsproxy/./luci-app-pcap-dnsproxy` 均返回 404。改用仓库根后可访问，后者需保留 `app` 分支；不是整个上游消失。 |

即使将 SVN 换成 Git，部分旧目录仍失效：

- [packages.sh:3](../packages.sh#L3)：`project-openwrt/openwrt` 已重定向至 `immortalwrt/immortalwrt`，旧 `package/ctcgfw/gost` 路径返回 404。
- [packages.sh:21](../packages.sh#L21)：`xiaorouji/openwrt-package` 已重定向至 `Openwrt-Passwall/openwrt-passwall`，旧 `lienol` 路径返回 404；同组 `obsolete`、`others`、`package` 也不能机械保留，需按新仓库布局迁移。
- [packages.sh:85](../packages.sh#L85)：`coolsnowwolf/lede` 的旧 `package/lean/luci-app-usb-printer` 路径返回 404。仓库可访问不代表旧子目录仍存在。

对三个旧脚本的 **194 个不同 Git URL** 做了匿名 `git ls-remote` 探测，其中 **19 个首次失败**。再用 HTTP 跟随重定向复核后，应分别判断：

| 复核结果 | 来源及原脚本位置 |
| --- | --- |
| HTTP 404，当前地址不可公开访问 | `sajati/luci-theme-waton`（19.07:11）、`xiaorouji/openwrt-passwall`（19.07:21、21.02:28）、`kiddin9/openwrt-bypass`（19.07:23）、`kiddin9/luci-app-eqos`（19.07:26）、`fszok/luci-app-advancedsetting`（19.07:43）、`jerrykuku/luci-app-vssr`（19.07:49） |
| HTTP 404，当前地址不可公开访问 | `small-5/ddns-scripts-dnspod`（19.07:60）、`small-5/ddns-scripts-aliyun`（19.07:61）、`koshev-msk/luci-app-modeminfo`（19.07:220、packages:101）、`yiguihai/luci-app-passwall-plus`（packages:99） |
| HTTP 404，当前地址不可公开访问 | `krystic/luci-app-cifs-mount`（21.02:68、208）、`jarod360/luci-app-xupnpd`（21.02:83）、`immortalwrt-collections/openwrt-gowebdav`（21.02:122）、`chinaboy2345/luci-app-ramfree`（21.02:202）、`2lambda123/openwrt-chinadns`（21.02:213） |
| HTTP 451，访问受限 | `sirpdboy/sirpdboy-package`（[21.02:19](../packages-21.02.sh#L19)）；不能据此认定删除。 |
| Git 探测失败，但 HTTP 200 | `jerrykuku/luci-app-jd-dailybonus`（[19.07:55](../packages-19.07.sh#L55)）；归为访问不稳定或协议结果不一致，不能列入确定删除清单。 |
| HTTP 404，URL 拼接错误 | 上表所列 21.02:172、179；修正仓库 URL 后可访问。 |

404 无法区分删除、转为私有、改名或其他访问限制。25.12 中的替换、去重和遗留来源保留方案见[逐行覆盖清单](../sources-25.12-coverage.tsv)与[迁移说明](migration-25.12.md)，不以一次失败静默删除原功能。

初次查询 GitHub 工作流 API 时，远端 `update-packages.yml` 返回 `state: disabled_inactivity`，`updated_at: 2025-07-15T02:19:22Z`。这是**检查时的远端状态**，本地修改 YAML 不会自动启用它；提交修改后仍需检查 Actions 页面并按需选择 **Enable workflow**。GitHub 官方说明：公开仓库连续 60 天没有活动时，[定时工作流可能自动停用](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/disable-and-enable-workflows)。

本次已经修复更新工作流：手动选择目标、明确写权限、固定 checkout 版本、同一分支串行发布、临时目录生成、显式 `bash -eo pipefail` 调用、生成失败停止发布、新分支首次创建、无变化正常结束、普通推送替代强制推送。实现见 [update-packages.yml:13](../.github/workflows/update-packages.yml#L13) 和[生成/发布步骤](../.github/workflows/update-packages.yml#L68)。

旧脚本中的 SVN、无效来源、未定义命令、重复 clone 和错误 URL **仍未修复**；旧目标会在失败时停止，不应解释为已恢复兼容。新 25.12 路径独立迁移完整来源集合，测试与兼容性边界以迁移说明为准。
