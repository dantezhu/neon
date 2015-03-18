local M = class("Neon")

function M:ctor()
    self.running = false
    self.scene = self:createScene()
    -- view类列表
    self.viewClasses = {}
    -- views列表
    self.views = {}

    -- 通过scene注册回调
    self.scene:registerScriptHandler(
        function (event_type)
            if (event_type == "enter") then
                self:onEnter()
            elseif (event_type == "enterTransitionFinish") then
                self:onEnterTransitionFinish()
            elseif (event_type == "exitTransitionStart") then
                self:onExitTransitionStart()
            elseif (event_type == "exit") then
                self:onExit()
            elseif (event_type == "cleanup") then
                self:onCleanup()

                self:cleanup()
            end
        end)

    self:onCreate()
end

function M:onCreate()
    -- 继承
end

function M:onRun()
    -- 继承
end

function M:onEnter()
    -- 继承
end
function M:onEnterTransitionFinish()
    -- 继承
end
function M:onExitTransitionStart()
    -- 继承
end
function M:onExit()
    -- 继承
end
function M:onCleanup()
    -- 继承
end

function M:createScene()
    -- 可以继承
    return cc.Scene:create()
end

-- 启动
-- renderView 希望继承者自己在onRun / onEnterTransitionFinish中实现，或者在run之后自己调用
-- onRun 和 onEnterTransitionFinish 的区别是view跟着scene一起进入还是等进入动画结束后再显示view
-- options: trans, push
function M:run(options)
    -- 启动过一次就不启动了
    if self.running then
        return
    else
        self.running = true
    end

    options = options or {}

    local transition = self.scene
    if options.trans then
        transition = options.trans(self.scene)
    end

    if cc.Director:getInstance():getRunningScene() then
        if options.push then
            cc.Director:getInstance():pushScene(transition)
        else
            cc.Director:getInstance():replaceScene(transition)
        end
    else
        cc.Director:getInstance():runWithScene(transition)
    end

    self:onRun()
end

-- 清空
function M:cleanup()
    self:removeAllViews()
    self.viewClasses = {}
    self.scene = nil
    neon.events:delHandlersForTarget(self)
end

function M:registerView(viewClass)
    self.viewClasses[viewClass.__cname] = viewClass
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

function M:renderView(name, params)
    -- 渲染view

    local view = self:getView(name)
    if not view then
        view = self:createView(name)
        if view then
            self.views[name] = view
        end
    end

    view:render(params)
end

function M:removeView(name)
    local view = self:getView(name)

    if view then
        -- 会自动从app中删掉，其作用在于view自己调用remove也可以用
        view:remove()
    end
end

function M:removeAllViews()
    for name,view in pairs(self.views) do
        self:removeView(name)
    end
end

function M:setViewVisible(name, visible)
    local view = self:getView(name)

    if view then
        view:setVisible(visible)
    end
end

function M:isViewVisible(name)
    local view = self:getView(name)

    if view then
        return view:isVisible()
    end
end

return M
