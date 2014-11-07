--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午1:58
-- To change this template use File | Settings | File Templates.
--

require("neon.utils")

local M = neon.class("Controller")

function M:ctor()
    self.view = nil
    self:initGlobalEvents()
end

function M:initGlobalEvents()
end

function M:initLocalEvents()
end

function M:removeLocalEvents()
end

function M:initView()
    neon.loge("you must overite this method !",self.TAG)
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
        self.view = self:initView()
        self:initLocalEvents()
    else 
        self.view:setVisibile(true)
    end

end

function M:getView()
    if not self.view then 
        self.view = self:initView()
        if not self.view then 
            neon.loge("can not get view ",self.TAG)
        else

        end
    end

    return self.view
end


return M
