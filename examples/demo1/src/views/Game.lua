require("neon.init")
require("cocos.init")

local M = neon.class("GameView", neon.View)

M.name = "game"

function M:onCreate()

    local layer = cc.LayerColor:create(cc.c4b(0,0,255,255))
    self.root:addChild(layer)
    
    local listener = cc.EventListenerTouchOneByOne:create()

    listener:registerScriptHandler(function (touch, event)
            self.app:removeView(self.name)
            neon.events:postEvent(EVT.show_loading, self.name)
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)
end

function M:onRemove()
    neon.loge("onRemove " .. self.name)
end

return M
