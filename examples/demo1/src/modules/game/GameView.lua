require("neon.init")
require("Cocos2d")

local M = neon.class("GameView", function(root)
    return neon.View.new(root)
end)

function M:ctor()
    local layer = cc.LayerColor:create(cc.c4b(0,0,255,255))
    self:addChild(layer)

end

return M