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
    return self:getViewClass().new(self)
end

function M:addAppEvent(name, callback)
    table.insert(self.appEvents, name)

    neon.events:addHandler(name, callback)
end

function M:addModuleEvent(name, callback)
    table.insert(self.moduleEvents, name)

    neon.events:addHandler(name, callback)
end

function M:clearAppEvents()
    for i=1,#self.appEvents do
        neon.events:delHandler(self.appEvents[i])
    end
    self.appEvents = {}
end

function M:clearModuleEvents()
    for i=1,#self.moduleEvents do
        neon.events:delHandler(self.moduleEvents[i])
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
        self:clearModuleEvents()
    end
end

function M:show()
    if not self.view then 
        self.view = self:createView()
        self.app.scene:addChild(self.view)
        self:initModuleEvents()
    else 
        self.view:setVisibile(true)
    end

end

return M
