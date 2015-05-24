local M = class("LoadingView", neon.View)

function M:onCreate(params)
    neon.logger:error("onCreate %s", self.__cname)

    local layer = cc.LayerColor:create(cc.c4b(255,0,255,255))

    self.label = cc.Label:createWithSystemFont("0", "Helvetica", 24)
    self.label:setPosition(cc.p(layer:getContentSize().width/2, layer:getContentSize().height/2))
    layer:addChild(self.label)

    self.root:addChild(layer)
    
    local listener = cc.EventListenerTouchOneByOne:create()

    listener:registerScriptHandler(function (touch, event)
            neon.events:postEvent(EVT.TEST)
            self.app:removeView(self.__cname)
            neon.events:postEvent(EVT.SHOW_GAME, self.__cname)
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)

    neon.events:addHandler(EVT.TEST, function ()
        neon.logger:error("evt test")
    end, self)

    if params.num ~= nil then
        self.label:setString(string.format("%d", params.num))
    end
end

function M:onRemove()
    neon.logger:error("onRemove %s", self.__cname)
end

return M
