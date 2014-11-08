
require("neon.init")
-- local GameView = neon.import(".GameView")
local GameView = require("modules.game.GameView")

local M = neon.class("GameController", function (app)
	return neon.Controller.new(app)
end)

function M:getViewClass()
    return GameView
end

return M