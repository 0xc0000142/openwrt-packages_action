module("luci.controller.samba", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/samba") then
        return
    end

    local page

    page = entry({
        "admin",
        "services",
        "samba"
    }, cbi("samba"), _("Network Shares"))
    page.dependent = true
end
