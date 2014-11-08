
require("neon.init")
local GameView = neon.import(".GameView")


local M = neon.class("GameController", function (app)
	return neon.Controller.new(app)
end)

function M:getViewClass()
    return GameView
end

function M:onCreateView()
end

function M:ctor(app)
end

return M