cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")


require "cocos.init"
require "neon.init"

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
print (msg)
    neon.loge("----------------------------------------")
    neon.loge("LUA ERROR: " .. tostring(msg) .. "\n")
    neon.loge(debug.traceback())
    neon.loge("----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(640, 960, cc.ResolutionPolicy.FIXED_WIDTH)

    require("MyApp").new():run()
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
