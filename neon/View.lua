--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午1:58
-- To change this template use File | Settings | File Templates.
--


require("neon.utils")

local M = neon.class("View", function()
    return cc.Layer:create()
end)

-- 继承者必须修改
M.name = nil

function M:ctor(app)
   self.app = app
end

function M:removeFromApp()
    neon.events:delHandlersForTarget(self)

    self:removeFromParent(true)
end

function M:onCreate()
    -- 继承重写
end

function M:onRemove()
    -- 继承重写
end

function M:onShow()
    -- 继承重写
end

function M:onHide()
    -- 继承重写
end

return M
