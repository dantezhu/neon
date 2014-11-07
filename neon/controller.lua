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
    self:initGlobalEvents()
end

function M:initGlobalEvents()
end

function M:initLocalEvents()
end

function M:removeLocalEvents()
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
        self:removeLocalEvents()
    end
end

function M:show()
    if not self.view then 
        self.view = self:createView()
        self:initLocalEvents()
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
