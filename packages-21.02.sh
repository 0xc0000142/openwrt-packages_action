#!/bin/bash
#Theme:
	svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-argonne
	svn co https://github.com/kenzok8/luci-theme-ifit/trunk/luci-theme-ifit
	svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-mcat
	svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-tomato
	svn co https://github.com/XXKDB/luci-theme-argon_armygreen/trunk ./luci-theme-argon_armygreen
	git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git
	git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git
	git clone --depth 1 https://github.com/tano-systems/luci-theme-tano.git
	git clone --depth 1 https://github.com/sajati/luci-theme-waton.git
	git clone --depth 1 https://github.com/52014app/luci-theme-edge.git
	git clone --depth 1 https://github.com/fhh200000/luci-theme-lafite-port.git

svn co https://github.com/kenzok8/openwrt-packages/trunk/
svn co https://github.com/cnsilvan/luci-app-unblockneteasemusic/trunk/UnblockNeteaseMusic ./UnblockNeteaseMusic-Go
svn co https://github.com/cnsilvan/luci-app-unblockneteasemusic/trunk/luci-app-unblockneteasemusic ./luci-app-UnblockNeteaseMusicGo
git clone --depth 1 https://github.com/Lienol/openwrt-package 
git clone --depth 1 https://github.com/goldkeyber112/openwrt-r8168.git
git clone --depth 1 https://github.com/fw876/helloworld && mvdir helloworld 
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall && mvdir openwrt-passwall 
git clone --depth 1 https://github.com/kiddin9/my-packages && mvdir my-packages 
git clone --depth 1 https://github.com/kiddin9/openwrt-bypass && mvdir openwrt-bypass 
git clone --depth 1 https://github.com/kiddin9/luci-app-dnsfilter 
git clone --depth 1 https://github.com/kiddin9/aria2 
git clone --depth 1 https://github.com/kiddin9/luci-app-eqos 
git clone --depth 1 https://github.com/kiddin9/luci-app-baidupcs-web 
git clone --depth 1 https://github.com/kiddin9/qBittorrent-Enhanced-Edition 
git clone --depth 1 https://github.com/kiddin9/autoshare && mvdir autoshare 
git clone --depth 1 https://github.com/kiddin9/openwrt-openvpn && my-packages openwrt-openvpn 
git clone --depth 1 https://github.com/BoringCat/luci-app-mentohust 
git clone --depth 1 https://github.com/kiddin9/luci-app-xlnetacc 
git clone --depth 1 https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk 
git clone --depth 1 https://github.com/rufengsuixing/luci-app-autoipsetadder 
git clone --depth 1 https://github.com/NateLol/luci-app-beardropper 
git clone --depth 1 https://github.com/riverscn/openwrt-iptvhelper && mvdir openwrt-iptvhelper 
git clone --depth 1 https://github.com/project-lede/luci-app-godproxy 
git clone --depth 1 https://github.com/BoringCat/luci-app-minieap 
git clone --depth 1 https://github.com/rufengsuixing/luci-app-onliner 
git clone --depth 1 https://github.com/tty228/luci-app-serverchan 
git clone --depth 1 https://github.com/4IceG/luci-app-sms-tool smstool && mvdir smstool 
git clone --depth 1 https://github.com/rufengsuixing/luci-app-usb3disable 
git clone --depth 1 https://github.com/fszok/luci-app-advancedsetting.git
git clone --depth 1 https://github.com/silime/luci-app-xunlei 
git clone --depth 1 https://github.com/ysc3839/luci-proto-minieap 
git clone --depth 1 https://github.com/zzsj0928/luci-app-pushbot 
git clone --depth 1 https://github.com/shanglanxin/luci-app-homebridge 
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config 
git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr 
git clone --depth 1 https://github.com/jerrykuku/luci-app-ttnode ttnode && mv -n ttnode/ttnode/* ./ ; rm -Rf ttnode 
git clone --depth 1 https://github.com/jefferymvp/luci-app-koolproxyR 
git clone --depth 1 https://github.com/peter-tank/luci-app-dnscrypt-proxy2 
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced 
git clone --depth 1 https://github.com/sirpdboy/luci-app-netdata 
git clone --depth 1 https://github.com/jerrykuku/luci-app-jd-dailybonus 
git clone --depth 1 https://github.com/NateLol/luci-app-oled 
git clone --depth 1 https://github.com/destan19/OpenAppFilter && mvdir OpenAppFilter 
git clone --depth 1 https://github.com/esirplayground/luci-app-poweroff 
git clone --depth 1 https://github.com/lvqier/luci-app-dnsmasq-ipset 
git clone --depth 1 https://github.com/small-5/ddns-scripts-dnspod 
git clone --depth 1 https://github.com/small-5/ddns-scripts-aliyun 
git clone --depth 1 https://github.com/walkingsky/luci-wifidog luci-app-wifidog 
git clone --depth 1 https://github.com/peter-tank/luci-app-autorepeater 
git clone --depth 1 https://github.com/CCnut/feed-netkeeper && mvdir feed-netkeeper 
git clone --depth 1 https://github.com/brvphoenix/luci-app-wrtbwmon wrtbwmon1 && mvdir wrtbwmon1 
git clone --depth 1 https://github.com/brvphoenix/wrtbwmon wrtbwmon2 && mvdir wrtbwmon2 
git clone --depth 1 https://github.com/linkease/ddnsto-openwrt && mvdir ddnsto-openwrt 
git clone --depth 1 https://github.com/sensec/luci-app-udp2raw 
git clone --depth 1 https://github.com/LGA1150/openwrt-sysuh3c && mvdir openwrt-sysuh3c 
git clone --depth 1 https://github.com/gdck/luci-app-cupsd cupsd1 && mv -n cupsd1/luci-app-cupsd cupsd1/cups/cups ./ ; rm -rf cupsd1 
svn export https://github.com/Lienol/openwrt/trunk/package/lean/luci-app-autoreboot 
svn export https://github.com/Tencent-Cloud-Plugins/tencentcloud-openwrt-plugin-ddns/trunk/tencentcloud_ddns luci-app-tencentddns 
svn export https://github.com/coolsnowwolf/lede/trunk/package/lean ledelean 
	mv -n ledelean/* ./
	rm -rf ledelean
svn export https://github.com/coolsnowwolf/lede/trunk/package/network/services/shellsync 
svn export https://github.com/coolsnowwolf/packages/trunk/net/miniupnpd 
svn export https://github.com/coolsnowwolf/packages/trunk/net/mwan3 
svn export https://github.com/x-wrt/packages/trunk/net/nft-qos 
svn export https://github.com/x-wrt/luci/trunk/applications/luci-app-nft-qos 
svn export https://github.com/immortalwrt/immortalwrt/trunk/package/lean/shadowsocksr-libev 
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash 
svn export https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman 
svn export https://github.com/doushang/luci-app-shortcutmenu/tunk/luci-app-shortcutmenu 
svn export https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-services-wolplus 
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-aria2
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-ddns
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-https-dns-proxy
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-acme
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-ksmbd
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-samba4 
svn co https://github.com/openwrt/packages/trunk/net/shadowsocks-libev
svn co https://github.com/openwrt/packages/trunk/net/https-dns-proxy
svn co https://github.com/openwrt/packages/trunk/net/openvpn
svn co https://github.com/openwrt/packages/trunk/net/adguardhome
svn co https://github.com/openwrt/packages/trunk/utils/cgroupfs-mount
svn co https://github.com/x-wrt/com.x-wrt/trunk/natflow
svn co https://github.com/x-wrt/com.x-wrt/trunk/luci-app-wizard
svn co https://github.com/x-wrt/com.x-wrt/trunk/luci-app-macvlan 
svn co https://github.com/immortalwrt/immortalwrt/trunk/package/kernel/mt7601u-ap
svn co https://github.com/immortalwrt/immortalwrt/trunk/package/kernel/mtk-eip93
svn co https://github.com/immortalwrt/immortalwrt/trunk/package/kernel/r8152
svn co https://github.com/immortalwrt/immortalwrt/trunk/package/kernel/r8168
svn co https://github.com/immortalwrt/immortalwrt/trunk/package/kernel/rtl8188eu
svn co https://github.com/immortalwrt/immortalwrt/trunk/package/kernel/rtl8812au-ac
svn co https://github.com/immortalwrt/immortalwrt/trunk/package/kernel/rtl8821cu
svn co https://github.com/immortalwrt/immortalwrt/trunk/package/kernel/rtl88x2bu
svn co https://github.com/immortalwrt/packages/trunk/net/mwol
svn co https://github.com/immortalwrt/packages/trunk/net/nps
svn co https://github.com/immortalwrt/packages/trunk/net/verysync
svn co https://github.com/immortalwrt/packages/trunk/net/sub-web
svn co https://github.com/immortalwrt/packages/trunk/net/subconverter
svn co https://github.com/immortalwrt/packages/trunk/net/ngrokc
svn co https://github.com/immortalwrt/packages/trunk/net/oscam
svn co https://github.com/immortalwrt/packages/trunk/net/njitclient
svn co https://github.com/immortalwrt/packages/trunk/net/scutclient
svn co https://github.com/immortalwrt/packages/trunk/net/gost
svn co https://github.com/immortalwrt/packages/trunk/net/amule
svn co https://github.com/immortalwrt/packages/trunk/net/gowebdav
svn co https://github.com/immortalwrt/packages/trunk/admin/bpytop
svn co https://github.com/immortalwrt/packages/trunk/libs/jpcre2
svn co https://github.com/immortalwrt/packages/trunk/libs/wxbase
svn co https://github.com/immortalwrt/packages/trunk/libs/rapidjson
svn co https://github.com/immortalwrt/packages/trunk/libs/libcron
svn co https://github.com/immortalwrt/packages/trunk/libs/quickjspp
svn co https://github.com/immortalwrt/packages/trunk/utils/cpulimit
svn co https://github.com/immortalwrt/packages/trunk/utils/filebrowser
svn co https://github.com/immortalwrt/packages/trunk/utils/phicomm-k3screenctrl
svn co https://github.com/immortalwrt/packages/trunk/multimedia/gmediarender

svn export --force https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications
for ipk in $(ls applications); do
	if [[ $ipk != "luci-app-transmission" && $(ls -l applications/$ipk/po | wc -l) -gt 3 ]]; then
		rm -rf applications/$ipk
	fi
done
cp -ufr applications/* ./ 
rm -rf applications/
sed -i 's/..\/..\/luci.mk/..\/luci.mk/g' ./*/Makefile
wget https://github.com/immortalwrt/luci/raw/openwrt-21.02/luci.mk
svn co https://github.com/rufengsuixing/luci-app-adguardhome/trunk ./luci-app-adguardhome
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-19.07/package/ntlf9t/luci-app-advancedsetting
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-aliddns
svn co https://github.com/frainzy1477/luci-app-clash/trunk ./luci-app-clash
rm -rf luci-app-openclash
rm -rf OpenClash
git clone https://github.com/vernesong/OpenClash.git
mv -f OpenClash/luci-app-openclash .
rm -rf OpenClash
svn co https://github.com/garypang13/luci-app-eqos/trunk ./luci-app-eqos
svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk ./luci-app-jd-dailybonus
svn co https://github.com/jerrykuku/luci-app-vssr/trunk ./luci-app-vssr
svn co https://github.com/tty228/luci-app-serverchan/trunk ./luci-app-serverchan
svn co https://github.com/fw876/helloworld/trunk ./
rm -rf .svn
svn co https://github.com/xiaorouji/openwrt-package/trunk/lienol ./
rm -rf .svn
svn co https://github.com/xiaorouji/openwrt-package/trunk/obsolete ./
rm -rf .svn
svn co https://github.com/xiaorouji/openwrt-package/trunk/others ./
rm -rf .svn
svn co https://github.com/xiaorouji/openwrt-package/trunk/package ./
rm -rf .svn
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-smartdns
svn co https://github.com/kenzok8/openwrt-packages/trunk/smartdns
svn co https://github.com/jerrykuku/node-request/trunk ./node-request
svn co https://github.com/jerrykuku/lua-maxminddb/trunk ./lua-maxminddb
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/UnblockNeteaseMusic
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/adbyby
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/baidupcs-web
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-baidupcs-web
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-adbyby-plus
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-airplay2
svn co https://github.com/cnzd/luci-app-koolproxyR/trunk ./luci-app-koolproxyR
svn co https://github.com/MiRouter/luci-app-vssr-plus/trunk ./luci-app-vssr-plus
svn co https://github.com/immortalwrt/packages/trunk/net/GoQuiet/
svn co https://github.com/immortalwrt/packages/trunk/net/chinadns
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman
svn co https://github.com/lisaac/luci-lib-docker/trunk/collections/luci-lib-docker
svn co https://github.com/lisaac/luci-app-diskman/trunk ./luci-app-diskman
rm -rf parted
mkdir parted
wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Parted.Makefile -O parted/Makefile
svn co https://github.com/destan19/OpenAppFilter/trunk ./
rm -rf .svn
svn co https://github.com/4IceG/luci-app-3ginfo/trunk/luci-app-3ginfo
rm -rf luci-app-wrtbwmon
rm -rf wrtbwmonluci
git clone https://github.com/brvphoenix/luci-app-wrtbwmon.git wrtbwmonluci
mv -f wrtbwmonluci/luci-app-wrtbwmon .
rm -rf wrtbwmonluci
svn co https://github.com/riverscn/openwrt-iptvhelper/trunk/iptvhelper
svn co https://github.com/riverscn/openwrt-iptvhelper/trunk/luci-app-iptvhelper
svn co https://github.com/brvphoenix/wrtbwmon/trunk/wrtbwmon
svn co https://github.com/KFERMercer/luci-app-tcpdump/trunk ./luci-app-tcpdump
svn co https://github.com/tty228/luci-app-nodogsplash/trunk ./luci-app-nodogsplash
svn co https://github.com/koshev-msk/luci-app-atinout/trunk ./luci-app-atinout
cp -r ./luci-app-atinout/atinout ./
svn co https://github.com/muink/luci-app-pcap-dnsproxy/branches/dev ./luci-app-pcap-dnsproxy
svn co https://github.com/koshev-msk/3proxy-openwrt/trunk ./3proxy
svn co https://github.com/pexcn/openwrt-chinadns-ng/branches/luci ./luci-app-chinadns-ng
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-usb-printer
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-ramfree
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-ttyd
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-unblockmusic
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-vlmcsd
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/vlmcsd
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-vsftpd
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cpufreq
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-xlnetacc
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-frpc
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/frp
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-frps
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ddns-scripts_aliyun
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ddns-scripts_dnspod
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cifs-mount
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-turboacc
git clone https://github.com/1mi9908303/luci-app-passwall-plus
svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/udpspeeder
git clone https://github.com/koshev-msk/luci-app-modeminfo
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/microsocks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/tcpping
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/dnsforwarder
git clone https://github.com/sensec/luci-app-udp2raw
svn co https://github.com/obsy/packages/trunk/3ginfo
git clone https://github.com/jerrykuku/luci-app-argon-config
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-socat
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/default-settings
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
rm -rf ./*/.svn 
rm -f .gitattributes .gitignore
exit 0
