require("neon.init")
require("Constants")


local M = neon.class("GameApp", neon.Neon)

function M:ctor()
    -- 基类
    self.super.ctor(self)

    self:registerView(require("views.Game"))
    self:registerView(require("views.Loading"))

    -- 只是演示，不一定要用事件来开启view，也可以直接调用
    neon.events:addHandler(EVT.show_loading, function (from)
        neon.loge("evt loading")
        self:showView("loading")
    end, self)

    neon.events:addHandler(EVT.show_game, function (from)
        neon.loge("evt game")
        self:showView("game")
    end, self)
end

return M
