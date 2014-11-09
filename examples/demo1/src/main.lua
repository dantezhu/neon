
require "Cocos2d"

-- cclog
local cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    
    cc.FileUtils:getInstance():addSearchPath("src")
    cc.FileUtils:getInstance():addSearchPath("res")
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(480, 320, 0)
    
    --create scene
    
    require("neon.init")
    require("Constants")

    local app = neon.Neon.new()
    app:registerController("loading", require("modules.loading.Controller"))
    app:registerController("game", require("modules.game.Controller"))

    app:run("loading")
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
