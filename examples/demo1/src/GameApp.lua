require("Constants")


local M = neon.class("GameApp", neon.Neon)

function M:onCreate()
    neon.logger:setLevel(neon.Log.WARN)

    self:registerView(require("views.GameView"))
    self:registerView(require("views.LoadingView"))

    -- 只是演示，不一定要用事件来开启view，也可以直接调用
    neon.events:addHandler(EVT.show_loading, function (from)
        self:showView("LoadingView")
    end, self)

    neon.events:addHandler(EVT.show_game, function (from)
        self:showView("GameView")
    end, self)
end

return M
