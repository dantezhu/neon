local M = class("MainView", neon.View)

function M:onCreate()
    neon.loge("onCreate %s", self.__cname)

    local layer = cc.LayerColor:create(cc.c4b(0,0,255,255))
    self.root:addChild(layer)

    self.label = cc.Label:createWithSystemFont("0", "Helvetica", 24)
    self.label:setPosition(cc.p(layer:getContentSize().width/2, layer:getContentSize().height/2))
    layer:addChild(self.label)

    
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

function M:onRender(params)
    neon.logd("params: %s", params)

    if params then
        self.label:setString(string.format("%d", params.num))
    end
end

return M
