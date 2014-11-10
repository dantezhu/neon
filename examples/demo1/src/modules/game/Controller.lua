
require("neon.init")

local M = neon.class("GameController", neon.Controller)

M.name = "game"
M.viewClass = neon.import(".View")

function M:onCreate()
    neon.loge("onCreate")
    neon.events:addHandler(EVT.show_game, function (from)
       print(from)
       self:show()
    end, nil)
end

function M:onCreateView()
    neon.loge("game onCreateView")
    neon.events:addHandler(EVT.test, function ()
        end, self)

end

function M:onDestroyView()
    neon.loge("game onDestroyView")
    neon.events:delHandlersForTarget(self)
end

return M
