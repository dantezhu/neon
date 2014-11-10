--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午1:58
-- To change this template use File | Settings | File Templates.
--

require("neon.utils")

local M = neon.class("Controller")

-- 继承者必须修改
M.name = nil
M.viewClass = nil

function M:ctor()
    self.app = nil
    self.view = nil

    self:onCreate()
end


function M:onCreate()
    -- 当创建时
end

function M:onCreateView()
    -- 当创建View时
end

function M:onDestroyView()
    -- 当删除View时
end

function M:createView()
    -- 创建view
    return self.viewClass.new(self)
end

function M:hide()
    self.view:setVisibile(false)
end

function M:remove()
    if self.view then
        self:onDestroyView()
        
        self.view:removeFromParent(true)
        self.view = nil
    end
end

function M:show()
    if not self.view then 
        self.view = self:createView()
        self.app.scene:addChild(self.view)

        self:onCreateView()
    else 
        self.view:setVisibile(true)
    end
end

return M
