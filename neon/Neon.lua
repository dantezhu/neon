require("neon.utils")

local M = neon.class("Neon")

function M:ctor()
    self.running = false
    self.scene = nil
    -- view类列表
    self.viewClasses = {}
    -- views列表
    self.views = {}

    self:onCreate()
end

function M:onCreate()
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

-- 启动
-- 不允许指定viewName，是因为希望继承者自己在onEnter中实现
function M:run(transFunc, pushScene)
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

function M:showView(name)
    local view = self:getView(name)
    if not view then
        view = self:createView(name)
        if view then
            self.views[name] = view
        end
    end

    view:show()
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

function M:hideView(name)
    local view = self:getView(name)

    if view then
        view:hide()
    end
end

return M
