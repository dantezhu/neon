
require("neon.init")

local M = neon.class("GameController", neon.Controller)

M.name = "game"
M.viewClass = neon.import(".View")

function M:onCreate()
    neon.loge("onCreate")
	neon.events:addHandler(EVT.show_game, function (name, from)
	   print(name, from)
	   self:show()
	end, self)
end

function M:onCreateView()
    neon.loge("game onCreateView")
    neon.events:addHandler(EVT.test, function (name)

        end, self)

end

function M:onDestoryView()
    neon.loge("game onDestoryView")
    neon.events:delHandlersForTarget(self)
end

return M
