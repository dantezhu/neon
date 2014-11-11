require("neon.utils")
require "Cocos2d"

local M = neon.class("Neon")

function M:ctor()
    self.running = false
    self.scene = nil
    -- view类列表
    self.viewClasses = {}
    -- views列表
    self.views = {}
end

-- 启动
function M:run(viewName, scene)
    -- 启动过一次就不启动了
    if self.running then
        return
    else
        self.running = true
    end

    -- 万一要支持切换动画，还可以做呢
    if scene then
        self.scene = scene
    else
        self.scene = cc.Scene:create()
    end

    self.scene:registerScriptHandler(
        function (event_type)
            if (event_type == "cleanup") then
                self:cleanup()
            end
        end)

    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(self.scene)
    else
        cc.Director:getInstance():runWithScene(self.scene)
    end

    self:showView(viewName)
end

-- 清空
function M:cleanup()
    neon.events:delHandlersForTarget(self)
    self:removeAllViews()
    self.viewClasses = {}
    self.scene = nil
end

function M:registerView(viewClass)
    self.viewClasses[viewClass.name] = viewClass
end

function M:createView(name)
    if self.viewClasses[name] then
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
    if not view then
        view = self:createView(name)
        if view then
            self.views[name] = view

            self.scene:addChild(view)
            view:onCreate()
        end
    end

    if view and not view:isVisible() then
        view:setVisible(true)
        -- 只有在从hide->show时调用
        view:onShow()
    end
end

function M:removeView(name)
    local view = self:getView(name)

    if view then
        view:onRemove()
        view:removeFromApp()

        self.views[name] = nil
    end
end

function M:removeAllViews()
    for name,view in pairs(self.views) do
        self:removeView(name)
    end
end

function M:hideView(name)
    local view = self:getView(name)

    if view then
        view:setVisible(false)

        view:onHide()
    end
end

return M
