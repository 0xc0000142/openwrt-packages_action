# openwrt-packages
国内常用OpenWrt软件包源码合集，每天自动更新，**不**建议使用lean源码 因为他的luci版本太拉了


18.06版luci请使用`packages`分支

19.07版luci请使用`packages-19.07`分支

21.\*版luci请使用`packages-21.02`分支

### 常用源码
| 提供者 | 名称 | Luci版本 | 地址 |  
| --- | -- | ------ | -- |
| Openwrt Officl | Openwrt 官方源 | 18.06~21.02(Def) |[https://github.com/openwrt/openwrt](https://github.com/openwrt/openwrt) |
| ImmortalWRT(China) | ImmortalWRT | 18.06(Def)~21.02 | [https://github.com/immortalwrt/immortalwrt](https://github.com/immortalwrt/immortalwrt)|
| Lean | Openwrt R21 | 18.06 |  [https://github.com/coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)|
| X-wrt | X-wrt | 21.02 | [https://github.com/x-wrt/x-wrt](https://github.com/x-wrt/x-wrt)|

## 食用方式（三选一，这里以21.02为例）：

**本仓库中包含可编译的 R8168 驱动 如果您希望使用请使用如下命令行安装仓库:**

`./scripts/feeds install -a -f`

`还是建议按需取用，不然碰到依赖问题不太好解决`

1. 先cd进package目录，然后执行

+ 21.02 `git clone -b packages-21.02 https://github.com/0xc0000142/openwrt-packages_action.git`
+ 19.07 `git clone -b packages-19.07 https://github.com/0xc0000142/openwrt-packages_action.git`
+ 18.06 `git clone -b packages https://github.com/0xc0000142/openwrt-packages_action.git`

2. 或者添加下面代码到feeds.conf.default文件

+ 21.02 `src-git 0xc0000142_packages https://github.com/0xc0000142/openwrt-packages_action.git;packages-21.02`
+ 19.07 `src-git 0xc0000142_packages https://github.com/0xc0000142/openwrt-packages_action.git;packages-19.07`
+ 18.06 `src-git 0xc0000142_packages https://github.com/0xc0000142/openwrt-packages_action.git;packages-18.06`

3. 先cd进package目录，然后执行

+ 21.02 `svn co https://github.com/0xc0000142/openwrt-packages_action/branches/packages-21.02`
+ 19.07 `svn co https://github.com/0xc0000142/openwrt-packages_action/branches/packages-19.07`
+ 18.06 `svn co https://github.com/0xc0000142/openwrt-packages_action/branches/packages`


## 不要为了下载而Fork这个项目
