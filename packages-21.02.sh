#!/bin/bash
#Theme:
        git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git
        git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git
        git clone --depth 1 https://github.com/52014app/luci-theme-edge.git
        git clone --depth 1 https://github.com/sirpdboy/luci-theme-opentopd

#svn co https://github.com/kenzok8/openwrt-packages/trunk/
#svn co https://github.com/cnsilvan/luci-app-unblockneteasemusic/trunk/UnblockNeteaseMusic ./UnblockNeteaseMusic-Go
#svn co https://github.com/cnsilvan/luci-app-unblockneteasemusic/trunk/luci-app-unblockneteasemusic ./luci-app-UnblockNeteaseMusicGo
git clone --depth 1 https://github.com/cnsilvan/luci-app-unblockneteasemusic/trunk/luci-app-unblockneteasemusic ./luci-app-UnblockNeteaseMusicGo 
git clone --depth 1  https://github.com/cnsilvan/luci-app-unblockneteasemusic/trunk/UnblockNeteaseMusic ./UnblockNeteaseMusic-Go 

git clone --depth 1 https://github.com/kenzok8/small-package.git
git clone --depth 1 https://github.com/Lienol/openwrt-package 
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
git clone --depth 1 https://github.com/fszok/luci-app-advancedsetting.git
git clone --depth 1 https://github.com/silime/luci-app-xunlei 
git clone --depth 1 https://github.com/ysc3839/luci-proto-minieap 
git clone --depth 1 https://github.com/zzsj0928/luci-app-pushbot 
git clone --depth 1 https://github.com/shanglanxin/luci-app-homebridge 
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config 
git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr 
git clone --depth 1 https://github.com/jerrykuku/luci-app-ttnode ttnode && mv -n ttnode/ttnode/* ./ ; rm -Rf ttnode 
git clone --depth 1 https://github.com/sirpdboy/luci-app-autotimeset
git clone --depth 1 https://github.com/sirpdboy/luci-app-poweroffdevice
git clone --depth 1 https://github.com/sirpdboy/luci-theme-kucat
git clone --depth 1 https://github.com/sirpdboy/luci-theme-parentcontrol
git clone --depth 1 https://github.com/sirpdboy/luci-app-advancedplus
git clone --depth 1 https://github.com/sirpdboy/luci-app-wizard
git clone --depth 1 https://github.com/sirpdboy/luci-app-partexp
git clone --depth 1 https://github.com/sirpdboy/luci-app-lukcy

git clone --depth 1 https://github.com/jefferymvp/luci-app-koolproxyR 
git clone --depth 1 https://github.com/peter-tank/luci-app-dnscrypt-proxy2 
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced 
git clone --depth 1 https://github.com/sirpdboy/luci-app-netdata 
git clone --depth 1 https://github.com/jerrykuku/luci-app-jd-dailybonus 
git clone --depth 1 https://github.com/NateLol/luci-app-oled 
git clone --depth 1 https://github.com/destan19/OpenAppFilter
git clone --depth 1 https://github.com/esirplayground/luci-app-poweroff 
git clone --depth 1 https://github.com/lvqier/luci-app-dnsmasq-ipset 
git clone --depth 1 https://github.com/small-5/ddns-scripts-dnspod 
git clone --depth 1 https://github.com/small-5/ddns-scripts-aliyun 
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

git clone --depth 1 https://github.com/Tencent-Cloud-Plugins/tencentcloud-openwrt-plugin-ddns/tencentcloud_ddns luci-app-tencentddns 
git clone --depth 1 https://github.com/riverscn/openwrt-iptvhelper/iptvhelper
git clone --depth 1 https://github.com/riverscn/openwrt-iptvhelper/luci-app-iptvhelper
git clone --depth 1 https://github.com/brvphoenix/wrtbwmon/wrtbwmon
git clone --depth 1 https://github.com/KFERMercer/luci-app-tcpdump ./luci-app-tcpdump
git clone --depth 1 https://github.com/tty228/luci-app-nodogsplash ./luci-app-nodogsplash
git clone --depth 1 https://github.com/koshev-msk/luci-app-atinout ./luci-app-atinout
cp -r ./luci-app-atinout/atinout ./
git clone --depth 1 https://github.com/muink/luci-app-pcap-dnsproxy/branches/dev ./luci-app-pcap-dnsproxy
git clone --depth 1 https://github.com/koshev-msk/3proxy-openwrt ./3proxy
git clone --depth 1 https://github.com/pexcn/openwrt-chinadns-ng/branches/luci ./luci-app-chinadns-ng
git clone --depth 1 https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/udpspeeder
git clone --depth 1 https://github.com/obsy/packages/3ginfo
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
git clone --depth 1 https://github.com/garypang13/luci-app-eqos ./luci-app-eqos
git clone --depth 1 https://github.com/jerrykuku/luci-app-jd-dailybonus ./luci-app-jd-dailybonus
git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr ./luci-app-vssr
git clone --depth 1 https://github.com/tty228/luci-app-serverchan ./luci-app-serverchan
git clone --depth 1 https://github.com/frainzy1477/luci-app-clash ./luci-app-clash
git clone --depth 1 https://github.com/rufengsuixing/luci-app-adguardhome ./luci-app-adguardhome




git clone --depth 1 https://github.com/coolsnowwolf/lede

lean_package=(
luci-app-usb-printer
luci-app-ramfree
luci-app-ttyd
luci-app-unblockmusic
luci-app-vlmcsd
vlmcsd
luci-app-vsftpd
luci-app-cpufreq
luci-app-xlnetacc
luci-app-frpc
frp
luci-app-frps
ddns-scripts_aliyun
ddns-scripts_dnspod
luci-app-cifs-mount
luci-app-turboacc
microsocks
redsocks2
tcpping
dnsforwarder
UnblockNeteaseMusic
baidupcs-web
luci-app-baidupcs-web
luci-app-airplay2
default-settings
)
for package in ${lean_package};do 
        mv lede/package/lean/$package .
done
mv lede/package/network/services/shellsync ./shellsync -f
mkdir UnblockNeteaseMusic
mkdir adbyby
mkdir baidupcs-web
mkdir luci-app-baidupcs-web
mkdir luci-app-adbyby-plus
mkdir luci-app-airplay2
mv lede/package/lean/UnblockNeteaseMusic ./UnblockNeteaseMusic -f
mv lede/package/lean/adbyby ./adbyby -f 
mv lede/package/lean/baidupcs-web ./baidupcs-web -f
mv lede/package/lean/luci-app-baidupcs-web ./luci-app-baidupcs-web -f
mv lede/package/lean/luci-app-adbyby-plus ./luci-app-adbyby-plus -f 
mv lede/package/lean/luci-app-airplay2./luci-app-airplay2 -f
rm -rf lede
mv small-packages/* ./ -n
rm -rf default-settings/files/zzz-default-settings
cat <<EOF >default-settings/files/zzz-default-settings
#!/bin/sh

uci set luci.main.lang=zh_cn
uci commit luci
uci set system.@system[0].timezone=CST-8
uci set system.@system[0].zonename=Asia/Shanghai
uci commit system
uci set fstab.@global[0].anon_mount=1
uci commit fstab
ln -sf /sbin/ip /usr/bin/ip
sed -i 's/downloads.openwrt.org/mirrors.tuna.tsinghua.edu.cn\/openwrt/g' /etc/opkg/distfeeds.conf
sed -i 's/http:/https:/g' /etc/opkg/distfeeds.conf
sed -i '/option check_signature/d' /etc/opkg.conf
sed -i "s/# //g" /etc/opkg/distfeeds.conf
sed -i '/option disabled/d' /etc/config/wireless
sed -i '/set wireless.radio${devidx}.disabled/d' /lib/wifi/mac80211.sh
sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
sed -i '/log-facility/d' /etc/dnsmasq.conf
echo "log-facility=/dev/null" >> /etc/dnsmasq.conf
echo 'hsts=0' > /root/.wgetrc
rm -rf /tmp/luci-modulecache/
rm -f /tmp/luci-indexcache

#从这里开始动 
#
#版本号
echo "DISTRIB_REVISION='Openwrt'" >> /etc/openwrt_release
#固件名称
echo "DISTRIB_DESCRIPTION='OpenWrt '" >> /etc/openwrt_release

exit 0
EOF

mv -f ./openwrt-r8168/* ./r8168/
rm -rf openwrt-r8168
rm -rf ./*/.git
rm -rf ./*/.#svn 
rm -f .gitattributes .gitignore
exit 0
