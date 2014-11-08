--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午1:58
-- To change this template use File | Settings | File Templates.
--

require("neon.utils")

local M = neon.class("Controller")

function M:ctor(rootView)
    self.rootView = rootView
    self.view = nil
    self.appEvents = {}
    self.moduleEvents = {}
end

function M:onCreateView()
    -- 当view创建时的回调
end

function M:addAppEvent(name, callback)
    table.insert(self.appEvents, name)

    neon.eventDispatcher:add(name, callback)
end

function M:addModuleEvent(name, callback)
    table.insert(self.moduleEvents, name)

    neon.eventDispatcher:add(name, callback)
end

function M:delAppEvents()
    for i=1,#self.appEvents do
        neon.eventDispatcher:del(self.appEvents[i])
    end
    self.appEvents = {}
end

function M:delModuleEvents()
    for i=1,#self.moduleEvents do
        neon.eventDispatcher:del(self.moduleEvents[i])
    end
    self.moduleEvents = {}
end

function M:createView()
    neon.loge("createView is empty", self.__cname)
    return nil
end

function M:hide()
    self.view:setVisibile(false)
end

function M:remove()
    if self.view then
        self.view:removeFromParent(true)
        self.view = nil
        self:delModuleEvents()
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
