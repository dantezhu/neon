
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

return M
