local M = class("Neon")

function M:ctor()
    self.running = false
    -- view类列表
    self.viewClasses = {}
    -- views列表
    self.views = {}
    -- views堆栈列表
    self.viewStack = {}

    -- scene
    self.scene = self:createScene()
    -- 进入效果, 可在onRun里面修改
    self.enterTransition = self.scene
    -- 是否替换旧scene
    self.replaceScene = true

    -- 通过scene注册回调
    self.scene:registerScriptHandler(
        function (eventType)
            if (eventType == "enter") then
                self:onEnter()
            elseif (eventType == "enterTransitionFinish") then
                self:onEnterTransitionFinish()
            elseif (eventType == "exitTransitionStart") then
                self:onExitTransitionStart()
            elseif (eventType == "exit") then
                self:onExit()
            elseif (eventType == "cleanup") then
                self:onCleanup()

                self:cleanup()
            end
        end)

    self:onCreate()
end

function M:onCreate()
    -- 继承
end

function M:onRun(params)
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
-- onRun 和 onEnterTransitionFinish 的区别是view跟着scene一起进入还是等进入动画结束后再显示view
function M:run(params)
    -- 启动过一次就不启动了
    if self.running then
        return
    else
        self.running = true
    end

    if params == nil then
        params = {}
    end
    self:onRun(params)

    if cc.Director:getInstance():getRunningScene() then
        if self.replaceScene then
            cc.Director:getInstance():replaceScene(self.enterTransition)
        else
            cc.Director:getInstance():pushScene(self.enterTransition)
        end
    else
        cc.Director:getInstance():runWithScene(self.enterTransition)
    end
end

-- 清空
function M:cleanup()
    self.running = false
    self:removeAllViews()
    self.viewClasses = {}
    self.scene = nil
    self.enterTransition = nil
    self.replaceScene = true
    neon.events:delHandlersForTarget(self)
end

function M:registerView(viewClass)
    self.viewClasses[viewClass.__cname] = viewClass
end

function M:createView(name, params)
    if self.viewClasses[name] then
        return self.viewClasses[name].new(self, params)
    else
        return nil
    end
end

function M:getView(name)
    return self.views[name]
end

function M:renderView(name, params)
    -- 渲染view
    --
    if params == nil then
        params = {}
    end

    -- 先把原来的清除掉
    self:removeView(name)

    view = self:createView(name, params)
    if view then
        self.views[name] = view
        table.insert(self.viewStack, view)
        view:resume()
    end

    return view
end

function M:removeView(name)
    local view = self:getView(name)

    if view then
        -- 会自动从app中删掉，其作用在于view自己调用remove也可以用
        view:remove()
    end
end

function M:removeAllViews(exclude)

    for name,view in pairs(self.views) do
        local canRemove = true

        if exclude then
            for i, v in ipairs(exclude) do
                if name == v then
                    canRemove = false
                    break
                end
            end
        end

        if canRemove then
            self:removeView(name)
        end
    end
end

function M:explicitRemoveView(view)
    -- 由view.remove() 中调用
    
    -- 防止删错
    if self.views[view.__cname] == view then
        self.views[view.__cname] = nil
    end

    local resumeNew = false

    if #self.viewStack > 0 and self.viewStack[#self.viewStack] == view then
        -- 说明最后一个view就是要删除的view，那么新的显示的view将会执行onResume
        resumeNew = true
    end

    -- 把所有相等的view都删掉，但实际上应该就一个
    table.removebyvalue(self.viewStack, view, true)

    if #self.viewStack > 0 then
        self.viewStack[#self.viewStack].resume()
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
