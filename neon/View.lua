--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午1:58
-- To change this template use File | Settings | File Templates.
--


local M = class("View")

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

function M:onVisibleChange(visible)
    -- 继承重写
end

function M:createRoot()
    -- 可以继承重写
    return cc.Layer:create()   
end

function M:remove()
    if self.root then
        -- 放在前面
        self:onRemove()

        self.root:removeFromParent(true)
        self.root = nil
    end

    -- 放在最后，免得中途又注册
    neon.events:delHandlersForTarget(self)
    -- 防止删错
    if self.app.views[self.__cname] == self then
        self.app.views[self.__cname] = nil
    end
end

function M:isVisible()
    return self.root ~= nil and self.root:isVisible()
end

function M:show()
    if self.root and not self.root:isVisible() then
        self.root:setVisible(true)
        self:onVisibleChange(true)
    end
end

function M:hide()
    if self.root and self.root:isVisible() then
        self.root:setVisible(false)
        self:onVisibleChange(false)
    end
end

return M
