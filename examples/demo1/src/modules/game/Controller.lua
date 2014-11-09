
require("neon.init")

local M = neon.class("GameController", neon.Controller)

M.name = "game"
M.viewClass = neon.import(".View")

function M:onCreate()
    neon.loge("onCreate")
	self:addAppEvent(EVT.show_game, function (from)
	   print(from)
	   self:show()
	end)
end

return M
