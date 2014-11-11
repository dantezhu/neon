require("neon.utils")
require "Cocos2d"

local M = neon.class("Neon")

function M:ctor()
    self.scene = nil
    -- view类列表
    self.viewClasses = {}
    -- views列表
    self.views = {}
end

-- 启动
function M:run(viewName, scene)
    if scene == nil then
        self.scene = cc.Scene:create()
    else
        self.scene = scene
    end

    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(self.scene)
    else
        cc.Director:getInstance():runWithScene(self.scene)
    end
    
    self:showView(viewName)
end

function M:registerView(viewClass)
    self.viewClasses[viewClass.name] = viewClass
end

function M:createView(name)
    if self.viewClasses[name] ~= nil then
        return self.viewClasses[name].new(self)
    else
        return nil
    end
end

function M:getView(name)
    return self.views[name]
end

function M:showView(name)
    local view = self:getView(name)
    if view == nil then
        view = self:createView(name)
        if view ~= nil then
            self.views[name] = view

            self.scene:addChild(view)
            view:onCreate()
        end
    end

    if not view:isVisible() then
        view:setVisible(true)
        -- 只有在从hide->show时调用
        view:onShow()
    end
end

function M:removeView(name)
    local view = self:getView(name)

    if view ~= nil then
        view:onRemove()
        view:removeFromParent(true)

        self.views[name] = nil
    end
end

function M:hideView(name)
    local view = self:getView(name)

    if view ~= nil then
        view:setVisible(false)

        view:onHide()
    end
end

return M
