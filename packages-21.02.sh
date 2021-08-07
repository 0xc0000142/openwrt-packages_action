#!/bin/bash
git clone --depth 1 https://github.com/Lienol/openwrt-package &
git clone --depth 1 https://github.com/fw876/helloworld && mvdir helloworld &
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall && mvdir openwrt-passwall &
git clone --depth 1 https://github.com/kiddin9/my-packages && mvdir my-packages &
git clone --depth 1 https://github.com/kiddin9/openwrt-bypass && mvdir openwrt-bypass &
git clone --depth 1 https://github.com/kiddin9/luci-app-dnsfilter &
git clone --depth 1 https://github.com/kiddin9/aria2 &
git clone --depth 1 https://github.com/kiddin9/luci-app-eqos &
git clone --depth 1 https://github.com/kiddin9/luci-app-baidupcs-web &
git clone --depth 1 https://github.com/kiddin9/luci-theme-edge &
git clone --depth 1 https://github.com/kiddin9/qBittorrent-Enhanced-Edition &
git clone --depth 1 https://github.com/kiddin9/autoshare && mvdir autoshare &
git clone --depth 1 https://github.com/kiddin9/openwrt-openvpn && my-packages openwrt-openvpn &
git clone --depth 1 https://github.com/BoringCat/luci-app-mentohust &
git clone --depth 1 https://github.com/kiddin9/luci-app-xlnetacc &
git clone --depth 1 https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk &
git clone --depth 1 https://github.com/rufengsuixing/luci-app-autoipsetadder &
git clone --depth 1 https://github.com/NateLol/luci-app-beardropper &
git clone --depth 1 https://github.com/riverscn/openwrt-iptvhelper && mvdir openwrt-iptvhelper &
git clone --depth 1 https://github.com/project-lede/luci-app-godproxy &
git clone --depth 1 https://github.com/BoringCat/luci-app-minieap &
git clone --depth 1 https://github.com/rufengsuixing/luci-app-onliner &
git clone --depth 1 https://github.com/tty228/luci-app-serverchan &
git clone --depth 1 https://github.com/4IceG/luci-app-sms-tool smstool && mvdir smstool &
git clone --depth 1 https://github.com/rufengsuixing/luci-app-usb3disable &
git clone --depth 1 https://github.com/silime/luci-app-xunlei &
git clone --depth 1 https://github.com/ysc3839/luci-proto-minieap &
git clone --depth 1 https://github.com/zzsj0928/luci-app-pushbot &
git clone --depth 1 https://github.com/shanglanxin/luci-app-homebridge &
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon &
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config &
git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr &
git clone --depth 1 https://github.com/jerrykuku/luci-app-ttnode ttnode && mv -n ttnode/ttnode/* ./ ; rm -Rf ttnode &
git clone --depth 1 https://github.com/jefferymvp/luci-app-koolproxyR &
git clone --depth 1 https://github.com/peter-tank/luci-app-dnscrypt-proxy2 &
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced &
git clone --depth 1 https://github.com/sirpdboy/luci-app-netdata &
git clone --depth 1 https://github.com/jerrykuku/luci-app-jd-dailybonus &
git clone --depth 1 https://github.com/NateLol/luci-app-oled &
git clone --depth 1 https://github.com/destan19/OpenAppFilter && mvdir OpenAppFilter &
git clone --depth 1 https://github.com/esirplayground/luci-app-poweroff &
git clone --depth 1 https://github.com/lvqier/luci-app-dnsmasq-ipset &
git clone --depth 1 https://github.com/small-5/ddns-scripts-dnspod &
git clone --depth 1 https://github.com/small-5/ddns-scripts-aliyun &
git clone --depth 1 https://github.com/walkingsky/luci-wifidog luci-app-wifidog &
git clone --depth 1 https://github.com/peter-tank/luci-app-autorepeater &
git clone --depth 1 https://github.com/CCnut/feed-netkeeper && mvdir feed-netkeeper &
git clone --depth 1 https://github.com/brvphoenix/luci-app-wrtbwmon wrtbwmon1 && mvdir wrtbwmon1 &
git clone --depth 1 https://github.com/brvphoenix/wrtbwmon wrtbwmon2 && mvdir wrtbwmon2 &
git clone --depth 1 https://github.com/linkease/ddnsto-openwrt && mvdir ddnsto-openwrt &
git clone --depth 1 https://github.com/sensec/luci-app-udp2raw &
git clone --depth 1 https://github.com/LGA1150/openwrt-sysuh3c && mvdir openwrt-sysuh3c &
git clone --depth 1 https://github.com/gdck/luci-app-cupsd cupsd1 && mv -n cupsd1/luci-app-cupsd cupsd1/cups/cups ./ ; rm -rf cupsd1 &
svn export https://github.com/Lienol/openwrt/trunk/package/lean/luci-app-autoreboot &
svn export https://github.com/Tencent-Cloud-Plugins/tencentcloud-openwrt-plugin-ddns/trunk/tencentcloud_ddns luci-app-tencentddns &
svn export https://github.com/coolsnowwolf/lede/trunk/package/lean ledelean &
svn export https://github.com/coolsnowwolf/lede/trunk/package/network/services/shellsync &
svn export https://github.com/coolsnowwolf/packages/trunk/net/miniupnpd &
svn export https://github.com/coolsnowwolf/packages/trunk/net/mwan3 &
svn export https://github.com/x-wrt/packages/trunk/net/nft-qos &
svn export https://github.com/x-wrt/luci/trunk/applications/luci-app-nft-qos &
svn export https://github.com/immortalwrt/immortalwrt/trunk/package/lean/shadowsocksr-libev &
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash &
svn export https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman &
svn export https://github.com/doushang/luci-app-shortcutmenu/tunk/luci-app-shortcutmenu &
svn export https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-services-wolplus &

git_sparse_clone openwrt-21.02 "https://github.com/openwrt/luci" "opluci" applications/luci-app-aria2 \
applications/luci-app-ddns applications/luci-app-https-dns-proxy applications/luci-app-acme \
applications/luci-app-ksmbd applications/luci-app-samba4 &

git_sparse_clone master "https://github.com/openwrt/packages" "oppackages" net/shadowsocks-libev net/https-dns-proxy \
net/openvpn net/adguardhome utils/cgroupfs-mount &

git_sparse_clone master "https://github.com/x-wrt/com.x-wrt" "x-wrt" natflow luci-app-wizard luci-app-macvlan &

git_sparse_clone master "https://github.com/immortalwrt/immortalwrt" "immwrt" package/kernel/mt7601u-ap package/kernel/mtk-eip93 \
package/kernel/r8152 package/kernel/r8168 package/kernel/rtl8188eu package/kernel/rtl8812au-ac \
package/kernel/rtl8821cu package/kernel/rtl88x2bu

git_sparse_clone master "https://github.com/immortalwrt/packages" "immpkgs" net/mwol net/nps net/verysync net/sub-web \
net/subconverter net/ngrokc net/oscam net/njitclient net/scutclient net/gost net/amule net/gowebdav \
admin/bpytop libs/jpcre2 libs/wxbase libs/rapidjson libs/libcron libs/quickjspp \
utils/cpulimit utils/filebrowser utils/phicomm-k3screenctrl multimedia/gmediarender multimedia/UnblockNeteaseMusic-Go

#svn export --force https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications
#for ipk in $(ls applications); do
#	if [[ $ipk != "luci-app-transmission" && $(ls -l applications/$ipk/po | wc -l) -gt 3 ]]; then
#		rm -rf applications/$ipk
#	fi
#done
#cp -ufr applications/* ./ 
#rm -rf applications/

svn co https://github.com/kenzok8/openwrt-packages/trunk/AdGuardHome
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-19.07/package/ctcgfw/gost
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
svn co https://github.com/project-openwrt/openwrt/branches/openwrt-19.07/package/ctcgfw/luci-app-gost
svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk ./luci-app-jd-dailybonus
svn co https://github.com/jerrykuku/luci-theme-argon/trunk ./luci-theme-argon
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
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-argon_new
svn co https://github.com/kenzok8/luci-theme-ifit/trunk/luci-theme-ifit
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial
svn co https://github.com/garypang13/luci-theme-edge/trunk ./luci-theme-edge
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-opentomato
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-opentomcat
svn co https://github.com/jerrykuku/node-request/trunk ./node-request
svn co https://github.com/jerrykuku/lua-maxminddb/trunk ./lua-maxminddb
svn co https://github.com/jerrykuku/luci-theme-argon/trunk ./luci-theme-argon
svn co https://github.com/jerrykuku/luci-app-argon-config/trunk ./luci-app-argon-config
svn co https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom/trunk/luci-theme-infinityfreedom
svn co https://github.com/XXKDB/luci-theme-argon_armygreen/trunk ./luci-theme-argon_armygreen


svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/UnblockNeteaseMusic
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/UnblockNeteaseMusicGo
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/adbyby
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/baidupcs-web
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-baidupcs-web
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-adbyby-plus
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-airplay2
svn co https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom/trunk/luci-theme-infinityfreedom
svn co https://github.com/cnzd/luci-app-koolproxyR/trunk ./luci-app-koolproxyR
svn co https://github.com/MiRouter/luci-app-vssr-plus/trunk ./luci-app-vssr-plus
svn co https://github.com/project-openwrt/openwrt/branches/openwrt-19.07/package/ctcgfw/GoQuiet
svn co https://github.com/project-openwrt/openwrt/branches/openwrt-19.07/package/ctcgfw/ChinaDNS
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
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/UnblockNeteaseMusic-Go
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/vlmcsd
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-vsftpd
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-xlnetacc
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-frpc
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/frp
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-frps
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ddns-scripts_aliyun
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ddns-scripts_dnspod
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cifs-mount
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-turboacc
git clone https://github.com/yiguihai/luci-app-passwall-plus
svn co https://github.com/project-openwrt/openwrt/branches/openwrt-19.07/package/ctcgfw/openwrt-udpspeeder
git clone https://github.com/koshev-msk/luci-app-modeminfo
svn co https://github.com/project-openwrt/openwrt/branches/openwrt-19.07/package/ntlf9t/openwrt-Pcap_DNSProxy
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/microsocks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/tcpping
svn co https://github.com/project-openwrt/openwrt/branches/openwrt-19.07/package/ntlf9t/dnscrypt-proxy-full
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/dnsforwarder
svn co https://github.com/project-openwrt/openwrt/branches/openwrt-19.07/package/ntlf9t/openwrt-udp2raw
svn co https://github.com/obsy/packages/trunk/3ginfo
git clone https://github.com/jerrykuku/luci-app-argon-config
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-socat
rm -rf ./*/.git
rm -rf ./*/.svn 
rm -f .gitattributes .gitignore
exit 0
