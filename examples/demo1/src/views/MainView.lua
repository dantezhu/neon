local M = neon.class("MainView", neon.View)

function M:onCreate()
    neon.loge("onCreate %s", self.__cname)

    local layer = cc.LayerColor:create(cc.c4b(0,0,255,255))
    self.root:addChild(layer)
    
    local listener = cc.EventListenerTouchOneByOne:create()

    listener:registerScriptHandler(function (touch, event)
            self.app:removeView(self.__cname)
            neon.events:postEvent(EVT.show_loading, self.__cname)
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)
end

function M:onRemove()
    neon.loge("onRemove %s", self.__cname)
end

return M