#!/bin/bash

[[ $(uci -q get poddns.config.enable) -eq 1 ]] || exit 0
token=$(uci -q get poddns.config.token)
sub_domain=$(uci -q get poddns.domain.sub_domain)
main_domain=$(uci -q get poddns.domain.main_domain)
logger -t poddns "Start update DDNS for ${sub_domain}.${main_domain}"
record=$(curl -s -4 -X POST https://dnsapi.cn/Record.List -d "login_token=${token}&domain=${main_domain}&sub_domain=${sub_domain}&format=json" | jq -r ".records[0]")
record_id=$(echo ${record} | jq -r ".id")
line_id=$(echo ${record} | jq -r ".line_id")
ddns_ip=$(echo ${record} | jq -r ".value")
wan_ip=$(ifstatus wan | jq -r '.["ipv4-address"][0].address')
if [[ "${wan_ip}" != "${ddns_ip}" ]]; then
    curl -4 -X POST https://dnsapi.cn/Record.Ddns -d "login_token=${token}&format=json&domain=${main_domain}&record_id=${record_id}&record_line_id=${line_id}&sub_domain=${sub_domain}&value=${wan_ip}" | jq | logger -t poddns
else
    logger -t poddns "WAN IP is not changed, skip update."
fi
