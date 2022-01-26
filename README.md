# openwrt-packages
国内常用OpenWrt软件包源码合集，每天自动更新，**不**建议使用lean源码 因为他的luci版本太拉了


18.06版luci请使用`packages`分支

19.07版luci请使用`packages-19.07`分支

21.\*版luci请使用`packages-21.02`分支

`lean源码用packages，op官方源码用packages-21.02 官方老版本用packages-19.07 `


## 食用方式（三选一，这里以21.02为例）：
`还是建议按需取用，不然碰到依赖问题不太好解决`
1. 先cd进package目录，然后执行
```bash
 git clone -b packages-21.02 https://github.com/0xc0000142/openwrt-packages_action/
```
2. 或者添加下面代码到feeds.conf.default文件
```bash
 src-git 0xc0000142_packages https://github.com/liuran001/openwrt-packages^packages-21.02
```
3. 先cd进package目录，然后执行
```bash
 svn co https://github.com/liuran001/openwrt-packages/branches/packages-21.02
```

## 不要为了下载而Fork这个项目
