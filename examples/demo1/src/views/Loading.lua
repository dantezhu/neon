local M = neon.class("GameView", neon.View)

M.name = "loading"

function M:onCreate()

    local layer = cc.LayerColor:create(cc.c4b(0,255,255,255))
    self.root:addChild(layer)
    
    local listener = cc.EventListenerTouchOneByOne:create()

    listener:registerScriptHandler(function (touch, event)
            neon.events:postEvent(EVT.test)
            self.app:removeView(self.name)
            neon.events:postEvent(EVT.show_game, self.name)
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)

    neon.events:addHandler(EVT.test, function ()
        neon.loge("evt test")
    end, self)
end

function M:onRemove()
    neon.loge("onRemove " .. self.name)
    neon.events:delHandlersForTarget(self)
end

return M
