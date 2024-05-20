require("luci.sys")

m = Map("poddns", translate("PoDdns"), translate("A simple Dnspod-CN DDNS client, only support IPv4."))

s = m:section(TypedSection, "poddns", translate("Basic Setting"))
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enable"))
token = s:option(Value, "token", translate("Token"), translate("Full API token(ID,Token) like xxxxx,xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"))

b = s:option(Button, "update", translate("Manual Update"))
b.inputtitle = translate("Update")
function b.write(self, section, value)
    luci.sys.call("/usr/share/poddns/poddns.sh")
end

s = m:section(TypedSection, "domain", translate("Domain Setting"))
s.addremove = false
s.anonymous = true

sub_domain = s:option(Value, "sub_domain", translate("Sub Domain"))
main_domain = s:option(Value, "main_domain", translate("Main Domain"))

m.on_after_commit = function(self)
    luci.sys.call("/etc/init.d/poddns restart")
end

return m
