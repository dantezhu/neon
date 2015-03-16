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
function neon.logd(...) 
    neon.logger:debug(...) 
end

function neon.logi(...) 
    neon.logger:info(...) 
end

function neon.logw(...) 
    neon.logger:warn(...) 
end

function neon.loge(...) 
    neon.logger:error(...) 
end
