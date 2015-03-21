local M = class("MainView", neon.View)

function M:onCreate()
    neon.loge("onCreate %s", self.__cname)

    local layer = cc.LayerColor:create(cc.c4b(0,0,255,255))
    self.root:addChild(layer)
end

function M:onRemove()
    neon.loge("onRemove %s", self.__cname)
end

function M:onRender(params)
    neon.logd("params: %s", params)
end

return M
