cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")


require "cocos.init"
require "neon.init"

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
print (msg)
    neon.logger:error("----------------------------------------")
    neon.logger:error("LUA ERROR: " .. tostring(msg) .. "\n")
    neon.logger:error(debug.traceback())
    neon.logger:error("----------------------------------------")
    return msg
end

local function appRun1()
    local app = require("MyApp").new()
    app:run()
    app:renderView("LoadingView")

    app = require("MyApp").new()
    app:run({
            trans=function (scene)
                return cc.TransitionFade:create(1,scene)
            end
    })
    app:renderView("MainView")
end

poped = false

local function appRun2()
    local app = require("MyApp").new()
    app:run()
    app:renderView("LoadingView")

    app = require("MyApp").new()
    app:run({
            trans=function (scene)
                return cc.TransitionFade:create(1,scene)
            end,
            replace=false
    })
    app:renderView("MainView")
    
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
    
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(480, 320, cc.ResolutionPolicy.SHOW_ALL)

    -- 无论是push还是pop还是replace，只要带上trans，连续调用两个刚才的函数，就会导致cleanup之类的函数执行不到。
    appRun1()
    -- appRun2()
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
