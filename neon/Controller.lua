--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午1:58
-- To change this template use File | Settings | File Templates.
--

require("neon.utils")

local M = neon.class("Controller")

function M:ctor(app)
    self.app = app

    self.view = nil
    self.appEvents = {}
    self.moduleEvents = {}
    
    self:initAppEvents()
end

function M:initAppEvents()
    -- 全局事件
end

function M:initModuleEvents()
    -- 本moduel事件
end

function M:getViewClass()
    -- 返回View类，继承重写
    return nil
end

function M:createView()
    -- 创建view
    return self:getViewClass().new(self.app.scene)
end

function M:addAppEvent(name, callback)
    table.insert(self.appEvents, name)

    self.app.eventDispatcher:addHandler(name, callback)
end

function M:addSelfEvent(name, callback)
    table.insert(self.moduleEvents, name)

    self.app.eventDispatcher:addHandler(name, callback)
end

function M:clearAppEvents()
    for i=1,#self.appEvents do
        self.app.eventDispatcher:delHandler(self.appEvents[i])
    end
    self.appEvents = {}
end

function M:clearSelfEvents()
    for i=1,#self.moduleEvents do
        self.app.eventDispatcher:delHandler(self.moduleEvents[i])
    end
    self.moduleEvents = {}
end

function M:hide()
    self.view:setVisibile(false)
end

function M:remove()
    if self.view then
        self.view:removeFromParent(true)
        self.view = nil
        self:clearSelfEvents()
    end
end

function M:show()
    if not self.view then 
        self.view = self:createView()
        self:initModuleEvents()
    else 
        self.view:setVisibile(true)
    end

end

function M:getView()
    if not self.view then 
        self.view = self:createView()
        if not self.view then 
            neon.loge("can not get view ", self.__cname)
        else

        end
    end

    return self.view
end


return M
