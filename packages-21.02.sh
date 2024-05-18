#!/bin/bash
#Theme:
        git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git
        git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git
        git clone --depth 1 https://github.com/52014app/luci-theme-edge.git
        git clone --depth 1 https://github.com/sirpdboy/luci-theme-opentopd

#svn co https://github.com/kenzok8/openwrt-packages/trunk/
#svn co https://github.com/cnsilvan/luci-app-unblockneteasemusic/trunk/UnblockNeteaseMusic ./UnblockNeteaseMusic-Go
#svn co https://github.com/cnsilvan/luci-app-unblockneteasemusic/trunk/luci-app-unblockneteasemusic ./luci-app-UnblockNeteaseMusicGo
git clone --depth 1 https://github.com/cnsilvan/luci-app-unblockneteasemusic/ ./luci-app-UnblockNeteaseMusicGo 
git clone --depth 1  https://github.com/cnsilvan/luci-app-unblockneteasemusic ./UnblockNeteaseMusic-Go 

git clone --depth 1 https://github.com/kenzok8/small-package.git ./package48748641
git clone --depth 1 https://github.com/Lienol/openwrt-package ./package136461651
git clone --depth 1 https://github.com/obsy/packages/ ./package165456316486
git clone --depth 1 https://github.com/0xc0000142/openwrt-r8168.git
git clone --depth 1 https://github.com/fw876/helloworld
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall 
git clone --depth 1 https://github.com/kiddin9/my-packages 
git clone --depth 1 https://github.com/kiddin9/openwrt-bypass 
git clone --depth 1 https://github.com/kiddin9/luci-app-dnsfilter 
git clone --depth 1 https://github.com/kiddin9/aria2 
git clone --depth 1 https://github.com/kiddin9/luci-app-eqos 
git clone --depth 1 https://github.com/kiddin9/luci-app-baidupcs-web 
git clone --depth 1 https://github.com/kiddin9/qBittorrent-Enhanced-Edition 
git clone --depth 1 https://github.com/kiddin9/autoshare 
git clone --depth 1 https://github.com/kiddin9/openwrt-openvpn  
git clone --depth 1 https://github.com/BoringCat/luci-app-mentohust 
git clone --depth 1 https://github.com/kiddin9/luci-app-xlnetacc 
git clone --depth 1 https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk 
git clone --depth 1 https://github.com/rufengsuixing/luci-app-autoipsetadder 
git clone --depth 1 https://github.com/NateLol/luci-app-beardropper 
git clone --depth 1 https://github.com/riverscn/openwrt-iptvhelper 
git clone --depth 1 https://github.com/project-lede/luci-app-godproxy 
git clone --depth 1 https://github.com/BoringCat/luci-app-minieap 
git clone --depth 1 https://github.com/rufengsuixing/luci-app-onliner 
git clone --depth 1 https://github.com/tty228/luci-app-serverchan 
git clone --depth 1 https://github.com/4IceG/luci-app-sms-tool smstool 
git clone --depth 1 https://github.com/rufengsuixing/luci-app-usb3disable 
git clone --depth 1 https://github.com/alvazhang79/luci-app-advancedsetting
git clone --depth 1 https://github.com/silime/luci-app-xunlei 
git clone --depth 1 https://github.com/ysc3839/luci-proto-minieap 
git clone --depth 1 https://github.com/zzsj0928/luci-app-pushbot 
git clone --depth 1 https://github.com/shanglanxin/luci-app-homebridge 
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config 
#git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr 
git clone --depth 1 https://github.com/jerrykuku/luci-app-ttnode 
git clone --depth 1 https://github.com/sirpdboy/luci-app-autotimeset
git clone --depth 1 https://github.com/sirpdboy/luci-app-poweroffdevice
git clone --depth 1 https://github.com/sirpdboy/luci-theme-kucat
git clone --depth 1 https://github.com/sirpdboy/luci-app-advancedplus
git clone --depth 1 https://github.com/sirpdboy/luci-app-wizard
git clone --depth 1 https://github.com/sirpdboy/luci-app-partexp

git clone --depth 1 https://github.com/jefferymvp/luci-app-koolproxyR 
git clone --depth 1 https://github.com/peter-tank/luci-app-dnscrypt-proxy2 
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced 
git clone --depth 1 https://github.com/sirpdboy/luci-app-netdata 
git clone --depth 1 https://github.com/noiver/luci-app-jd-dailybonus
git clone --depth 1 https://github.com/NateLol/luci-app-oled 
git clone --depth 1 https://github.com/destan19/OpenAppFilter
git clone --depth 1 https://github.com/esirplayground/luci-app-poweroff 
git clone --depth 1 https://github.com/lvqier/luci-app-dnsmasq-ipset 
git clone --depth 1 https://github.com/walkingsky/luci-wifidog luci-app-wifidog 
git clone --depth 1 https://github.com/peter-tank/luci-app-autorepeater 
git clone --depth 1 https://github.com/CCnut/feed-netkeeper 
git clone --depth 1 https://github.com/brvphoenix/luci-app-wrtbwmon 
git clone --depth 1 https://github.com/brvphoenix/wrtbwmon  
git clone --depth 1 https://github.com/linkease/ddnsto-openwrt 
git clone --depth 1 https://github.com/sensec/luci-app-udp2raw 
git clone --depth 1 https://github.com/LGA1150/openwrt-sysuh3c 
git clone --depth 1 https://github.com/gdck/luci-app-cupsd cupsd1 && mv -n cupsd1/luci-app-cupsd cupsd1/cups/cups ./ ; rm -rf cupsd1 
git clone --depth 1 https://github.com/4IceG/luci-app-socat.git

git clone --depth 1 https://github.com/msylgj/luci-app-tencentddns
git clone --depth 1 https://github.com/riverscn/openwrt-iptvhelper/
git clone --depth 1 https://github.com/brvphoenix/wrtbwmon/wrtbwmon
git clone --depth 1 https://github.com/KFERMercer/luci-app-tcpdump ./luci-app-tcpdump
git clone --depth 1 https://github.com/tty228/luci-app-nodogsplash ./luci-app-nodogsplash
git clone --depth 1 https://github.com/SankySyS/luci-app-atinout ./luci-app-atinout
git clone --depth 1 https://github.com/4IceG/luci-app-atinout-mod
git clone --depth 1 https://github.com/izilzty/luci-app-chinadns-ng
cp -r ./luci-app-atinout/atinout ./

git clone --depth 1 https://github.com/muink/luci-app-pcap-dnsproxy/./luci-app-pcap-dnsproxy
git clone --depth 1 https://github.com/osnosn/3proxy-openwrt ./3proxy

git clone --depth 1 https://github.com/lisaac/luci-app-diskman ./luci-app-diskman
mkdir parted
wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Parted.Makefile -O parted/Makefile
git clone --depth 1 https://github.com/destan19/OpenAppFilter 
git clone --depth 1 https://github.com/4IceG/luci-app-3ginfo/
git clone --depth 1 https://github.com/lisaac/luci-app-dockerman/
git clone --depth 1 https://github.com/lisaac/luci-lib-docker/
git clone --depth 1 https://github.com/lisaac/luci-app-diskman ./luci-app-diskman
git clone --depth 1 https://github.com/cnzd/luci-app-koolproxyR ./luci-app-koolproxyR
git clone --depth 1 https://github.com/MiRouter/luci-app-vssr-plus ./luci-app-vssr-plus
git clone --depth 1 https://github.com/jerrykuku/node-request ./node-request
git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb ./lua-maxminddb
git clone --depth 1 https://github.com/Huangjoe123/luci-app-eqos ./luci-app-eqos
git clone --depth 1 https://github.com/sirpdboy/luci-app-eqosplus
git clone --depth 1 https://github.com/noiver/luci-app-jd-dailybonus ./luci-app-jd-dailybonus
#git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr ./luci-app-vssr
git clone --depth 1 https://github.com/tty228/luci-app-serverchan ./luci-app-serverchan
git clone --depth 1 https://github.com/frainzy1477/luci-app-clash ./luci-app-clash
git clone --depth 1 https://github.com/rufengsuixing/luci-app-adguardhome ./luci-app-adguardhome
git clone --depth 1 https://github.com/chenmozhijin/turboacc
git clone --depth 1 https://github.com/siwind/luci-app-usb_printer
git clone --depth 1 https://github.com/chinaboy2345/luci-app-ramfree
git clone --depth 1 https://github.com/animefansxj/luci-app-vsftpd
git clone --depth 1 https://github.com/openwrt-xiaomi/luci-app-cpufreq
git clone --depth 1 https://github.com/sensec/luci-app-xlnetacc
git clone --depth 1 https://github.com/sensec/ddns-scripts_aliyun
git clone --depth 1 https://github.com/starsunyzl/ddns-scripts-dnspod
git clone --depth 1 https://github.com/krystic/luci-app-cifs-mount
git clone --depth 1 https://github.com/KFERMercer/luci-app-baidupcs-web
git clone --depth 1 https://github.com/KFERMercer/openwrt-baidupcs-web ./baidupcs-web 
git clone --depth 1 https://github.com/ghostnup/default-settings
git clone --depth 1 https://github.com/kuoruan/openwrt-kcptun ./kcptun
git clone --depth 1 https://github.com/honwen/openwrt-shadowsocksr ./shadowsocksr-libev
git clone --depth 1 https://github.com/2lambda123/openwrt-chinadns ./chinadns
git clone --depth 1 https://github.com/pexcn/openwrt-udpspeeder ./udpspeeder
git clone --depth 1 https://github.com/gw826943555/openwrt-cpufreq ./cpufreq
git clone --depth 1 https://github.com/padre-lacroix/bandwidthd-openwrt ./bandwidthd

remove_packages=(
base-files
dnsmasq
firewall
firewall4
fullconenat
fullconenat-nft
libnftnl
nftables
opkg
ppp
wireless-regdb
)
for package in ${remove_packages[@]};do 
        echo Remoing Package:$package
        rm -rf package48748641/$package
done

mv package48748641/* ./ -n
mv package136461651/* ./ -n
mv package165456316486/* ./ -n
rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore README.md ./*/README.md ./*/*/README.md
rm -rf ./package48748641 ./package136461651

mkdir r8168
mv -f ./openwrt-r8168/* ./r8168/
rm -rf openwrt-r8168
rm -rf ./*/.git
rm -rf ./*/.#svn 
rm -f .gitattributes .gitignore
exit 0
