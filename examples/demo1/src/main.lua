require "cocos.init"

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

local function appRun1()
    local app = require("GameApp").new()
    app:run()
    app:showView("loading")

    app = require("GameApp").new()
    app:run(function (scene)
        return cc.TransitionFade:create(1,scene)
    end)
    app:showView("game")
end

poped = false

local function appRun2()
    local app = require("GameApp").new()
    app:run()
    app:showView("loading")

    app = require("GameApp").new()
    app:run(function (scene)
        return cc.TransitionFade:create(1,scene)
    end, true)
    app:showView("game")
    
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(function() 
        if not poped then
            poped = true   
            cc.Director:getInstance():popScene()
         end
    end,2,false)
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    
    cc.FileUtils:getInstance():addSearchPath("src")
    cc.FileUtils:getInstance():addSearchPath("res")
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(480, 320, cc.ResolutionPolicy.SHOW_ALL)

    -- 无论是push还是pop还是replace，只要带上trans，连续调用两个刚才的函数，就会导致cleanup之类的函数执行不到。
    appRun1()
    -- appRun2()
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
