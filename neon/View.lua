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
    -- view创建时，继承重写
end

function M:onRender(params)
    -- view被渲染时，继承重写
end

function M:onRemove()
    -- view被移除时，继承重写
end

function M:onVisibleChange(visible)
    -- 继承重写
end

function M:createRoot()
    -- 可以继承重写
    return cc.Layer:create()   
end

function M:render(params)
    -- 渲染
    self:onRender(params)
end

function M:remove()
    if not self.root then
        -- 保证重复调用无效
        return
    end

    -- 放在前面
    self:onRemove()

    self.root:removeFromParent(true)
    self.root = nil

    -- 放在最后，免得中途又注册
    neon.events:delHandlersForTarget(self)
    -- 防止删错
    if self.app.views[self.__cname] == self then
        self.app.views[self.__cname] = nil
    end
end

function M:isVisible()
    return self.root and self.root:isVisible()
end

function M:setVisible(visible)
    if self.root and self.root:isVisible() ~= visible then
        self.root:setVisible(visible)
        self:onVisibleChange(visible)
    end
end

return M
