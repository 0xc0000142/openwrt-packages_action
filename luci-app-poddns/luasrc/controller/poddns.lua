module("luci.controller.poddns", package.seeall)

function index()
    entry({"admin", "services", "poddns"}, cbi("poddns/index"), _("PoDdns"), 1).leaf = true
end