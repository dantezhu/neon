require("neon.init")
require("Cocos2d")

local M = neon.class("LoadingView", neon.View)

function M:ctor(controller)
    self.super.ctor(self, controller)
    
    local layer = cc.LayerColor:create(cc.c4b(255,0,255,255))
    self:addChild(layer)
    
    local listener = cc.EventListenerTouchOneByOne:create()
    
    listener:registerScriptHandler(function (touch, event)
        self.controller:remove()
        neon.events:postEvent(EVT.show_game, "loading")
    end, cc.Handler.EVENT_TOUCH_BEGAN)
    
    layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)
end

return M
