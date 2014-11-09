require("neon.init")
require("Cocos2d")

local M = neon.class("GameView", function(controller)
    return neon.View.new(controller)
end)

function M:ctor(controller)
    local layer = cc.LayerColor:create(cc.c4b(0,0,255,255))
    self:addChild(layer)

end

return M
