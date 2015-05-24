local M = class("MainView", neon.View)

function M:onCreate(params)
    neon.logger:error("onCreate %s", self.__cname)

    local layer = cc.LayerColor:create(cc.c4b(0,0,255,255))
    self.root:addChild(layer)

    self.label = cc.Label:createWithSystemFont("0", "Helvetica", 24)
    self.label:setPosition(cc.p(layer:getContentSize().width/2, layer:getContentSize().height/2))
    layer:addChild(self.label)

    
    local listener = cc.EventListenerTouchOneByOne:create()

    listener:registerScriptHandler(function (touch, event)
            self.app:removeView(self.__cname)
            neon.events:postEvent(EVT.SHOW_LOADING, self.__cname)
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    layer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)

    if params.num ~= nil then
        self.label:setString(string.format("%d", params.num))
    end
end

function M:onRemove()
    neon.logger:error("onRemove %s", self.__cname)
end

function M:onResume()
    neon.logger:error("%s", self.__cname)
end

return M
