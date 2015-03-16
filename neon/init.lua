--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午10:24
-- To change this template use File | Settings | File Templates.
--

neon = neon or {}

neon.Log = require("neon.Log")
neon.View = require("neon.View")
neon.Events = require("neon.Events")
neon.Neon = require("neon.Neon")

-- 默认logger
neon.logger = neon.Log.new()
-- events是可以跨app的
neon.events = neon.Events.new()

-- 常用函数
-- log相关
function neon.logd(msg,tag) 
    neon.logger:debug(msg,tag) 
end

function neon.logi(msg,tag) 
    neon.logger:info(msg,tag) 
end

function neon.logw(msg,tag) 
    neon.logger:warn(msg,tag) 
end

function neon.loge(msg,tag) 
    neon.logger:error(msg,tag) 
end
