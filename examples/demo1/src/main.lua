
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

local function createApp()
    local app = neon.Neon.new()
    app:addModule(require("modules.loading.Controller"))
    app:addModule(require("modules.game.Controller"))

    return app
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    
    cc.FileUtils:getInstance():addSearchPath("src")
    cc.FileUtils:getInstance():addSearchPath("res")
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(480, 320, 0)
    
    require("neon.init")
    require("Constants")

    -- 直接就是全局的了
    gapp = createApp()
    gapp:run("loading")
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
