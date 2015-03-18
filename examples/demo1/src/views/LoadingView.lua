local M = class("LoadingView", neon.View)

function M:onCreate()
    neon.loge("onCreate %s", self.__cname)

    local layer = cc.LayerColor:create(cc.c4b(255,0,255,255))

    self.label = cc.Label:createWithSystemFont("0", "Helvetica", 24)
    self.label:setPosition(cc.p(layer:getContentSize().width/2, layer:getContentSize().height/2))
    layer:addChild(self.label)

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

function M:onRender(params)
    neon.logd("params: %s", params)

    if params then
        self.label:setString(string.format("%d", params.num))
    end
end

return M
