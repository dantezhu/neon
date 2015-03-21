require("Constants")


local M = class("MyApp", neon.Neon)

function M:onCreate()
    self.num = 0

    neon.logger:setLevel(neon.logging.DEBUG)

    self:registerView(require("views.MainView"))
    self:registerView(require("views.LoadingView"))

    -- 只是演示，不一定要用事件来开启view，也可以直接调用
    neon.events:addHandler(EVT.show_loading, function (from)
        self.num = self.num + 1
        self:renderView("LoadingView", {num=self.num})
    end, self)

    neon.events:addHandler(EVT.show_game, function (from)
        self.num = self.num + 1
        self:renderView("MainView", {num=self.num})
    end, self)
end

function M:onRun(params)
    neon.logd("onRun. params: %s", params)

    if params and params.trans ~= nil then
        self.enterTransition = params.trans(self.scene)
    end

    if params and params.replace ~= nil then
        self.replaceScene = params.replace
    end
end

return M
