#!/bin/sh

[ $(uci -q get poddns.config.enable) = 1 ] || exit 0
wan_ip=$(ifstatus wan | jsonfilter -e '@["ipv4-address"][0].address')
token=$(uci -q get poddns.config.token)
sub_domain=$(uci -q get poddns.domain.sub_domain)
main_domain=$(uci -q get poddns.domain.main_domain)
ddns_ip=$(curl -4 -s -X POST https://dnsapi.cn/Record.List -d "login_token=$token&domain=$main_domain&sub_domain=$sub_domain&format=json" | jsonfilter -e "@.records[0].value")
if [ "$wan_ip" != "$ddns_ip" ]; then
    logger -t poddns "WAN IP $wan_ip mismatch with DDNS IP $ddns_ip. Start update DDNS for $sub_domain.$main_domain"
    /usr/share/poddns/poddns.sh
fi
