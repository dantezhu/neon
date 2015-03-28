local M = class("MainView", neon.View)

function M:onCreate()
    neon.logger:error("onCreate %s", self.__cname)

    local layer = cc.LayerColor:create(cc.c4b(0,0,255,255))
    self.root:addChild(layer)
end

function M:onRemove()
    neon.logger:error("onRemove %s", self.__cname)
end

function M:onRender(params)
    neon.logger:debug("params: %s", tostring(params))
end

return M
