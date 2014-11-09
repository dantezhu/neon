
require("neon.init")
local ViewClass = neon.import(".View")


local M = neon.class("GameController", neon.Controller)


function M:initAppEvents()
    neon.loge("initAppEvents")
	self:addAppEvent(EVT.show_game, function (from)
	   print(from)
	   self:show()
	end)
end

function M:getViewClass()
    return ViewClass
end

return M