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
end

function M:onCreateView()
    -- 当创建view后
end

function M:createView()
    -- 创建view, 需要覆盖
    return nil
end

function M:getName()
    -- 继承需要重写
   return nil
end

function M:addAppEvent(name, callback)
    table.insert(self.appEvents, name)

    self.app.eventDispatcher:add(name, callback)
end

function M:addSelfEvent(name, callback)
    table.insert(self.moduleEvents, name)

    self.app.eventDispatcher:add(name, callback)
end

function M:clearAppEvents()
    for i=1,#self.appEvents do
        self.app.eventDispatcher:del(self.appEvents[i])
    end
    self.appEvents = {}
end

function M:clearSelfEvents()
    for i=1,#self.moduleEvents do
        self.app.eventDispatcher:del(self.moduleEvents[i])
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
        self:onCreateView()
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
