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
function M:run(viewName, transFunc, pushScene)
    -- 启动过一次就不启动了
    if self.running then
        return
    else
        self.running = true
    end

    self.scene = cc.Scene:create()

    -- 通过scene注册回调
    self.scene:registerScriptHandler(
        function (event_type)
            if (event_type == "enter") then
                if self.onEnter then
                    self:onEnter()
                end
            elseif (event_type == "enterTransitionFinish") then
                if self.onEnterTransitionFinish then
                    self:onEnterTransitionFinish()
                end
            elseif (event_type == "exitTransitionStart") then
                if self.onExitTransitionStart then
                    self:onExitTransitionStart()
                end
            elseif (event_type == "exit") then
                if self.onExit then
                    self:onExit()
                end
            elseif (event_type == "cleanup") then
                if self.onCleanup then
                    self:onCleanup()
                end

                self:cleanup()
            end
        end)

    local transition = self.scene
    if transFunc then
        transition = transFunc(self.scene)
    end

    if cc.Director:getInstance():getRunningScene() then
        if pushScene then
            cc.Director:getInstance():pushScene(transition)
        else
            cc.Director:getInstance():replaceScene(transition)
        end
    else
        cc.Director:getInstance():runWithScene(transition)
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
