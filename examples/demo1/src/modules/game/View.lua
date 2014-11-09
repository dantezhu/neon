require("neon.init")
require("Cocos2d")

local M = neon.class("GameView", neon.View)

function M:onCreate()

    local layer = cc.LayerColor:create(cc.c4b(0,0,255,255))
    self:addChild(layer)
    
    local listener = cc.EventListenerTouchOneByOne:create()

    local listener = cc.EventListenerTouchOneByOne:create()

    listener:registerScriptHandler(function (touch, event)
        self.controller:remove()
        neon.events:postEvent(EVT.show_loading, "game")
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)
end

return M
