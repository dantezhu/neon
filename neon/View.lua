--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午1:58
-- To change this template use File | Settings | File Templates.
--


require("neon.utils")
require "Cocos2d"

local M = neon.class("View")

-- 继承者必须修改
M.name = nil

function M:ctor(app)
   self.app = app

   -- 节点
   self.root = self:createRoot()
   self.app.scene:addChild(self.root)

   self:onCreate()
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

function M:createRoot()
    -- 可以继承重写
    return cc.Layer:create()   
end

function M:remove()
    neon.events:delHandlersForTarget(self)

    if self.root then
        self.root:removeFromParent(true)
        self.root = nil

        self:onRemove()
    end
end

function M:isVisible()
    return self.root ~= nil and self.root:isVisible()
end

function M:show()
    if self.root and not self.root:isVisible() then
        self.root:setVisible(true)
        self:onShow()
    end
end

function M:hide()
    if self.root and self.root:isVisible() then
        self.root:setVisible(false)
        self:onHide()
    end
end

return M
