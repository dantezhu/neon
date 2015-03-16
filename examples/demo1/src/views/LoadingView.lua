local M = class("LoadingView", neon.View)

function M:onCreate()
    neon.loge("onCreate %s", self.__cname)

    local layer = cc.LayerColor:create(cc.c4b(0,255,255,255))
    self.root:addChild(layer)
    
    local listener = cc.EventListenerTouchOneByOne:create()

    listener:registerScriptHandler(function (touch, event)
            neon.events:postEvent(EVT.test)
            self.app:removeView(self.__cname)
            neon.events:postEvent(EVT.show_game, self.__cname)
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)

    neon.events:addHandler(EVT.test, function ()
        neon.loge("evt test")
    end, self)
end

function M:onRemove()
    neon.loge("onRemove %s", self.__cname)
    neon.events:delHandlersForTarget(self)
end

return M
