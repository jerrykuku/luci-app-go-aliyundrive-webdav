-- Copyright (C) 2021 jerryk <jerrykuku@qq.com>
-- This is free software, licensed under the APACHE LICENSE, VERSION 2.0.


local uci = luci.model.uci.cursor()
local m, e

m = Map("go-aliyundrive-webdav", translate("Go AliyunDrive WebDAV"),
        translate("<a href=\"https://github.com/LinkLeong/go-aliyun-webdav\" target=\"_blank\">Project GitHub URL</a>"))

m:section(SimpleSection).template = "go-aliyundrive-webdav/status"

e = m:section(TypedSection, "server")
e.anonymous = true

enable = e:option(Flag, "enable", translate("Enable"))
enable.rmempty = false

refresh_token = e:option(Value, "refresh_token", translate("Refresh Token"),
        translate("<a href=\"https://github.com/LinkLeong/go-aliyun-webdav#%E6%B5%8F%E8%A7%88%E5%99%A8%E8%8E%B7%E5%8F%96refreshtoken%E6%96%B9%E5%BC%8F\" target=\"_blank\">How to get refresh token</a>"))

port = e:option(Value, "port", translate("Port"))
port.default = "8085"
port.datatype = "port"

auth_user = e:option(Value, "auth_user", translate("Username"))
auth_user.default = "admin"

auth_pwd = e:option(Value, "auth_pwd", translate("Password"))
auth_pwd.password = true
auth_pwd.default = "123456"


local e = luci.http.formvalue("cbi.apply")
if e then
    io.popen("/etc/init.d/go-aliyundrive-webdav restart")
end
return m
