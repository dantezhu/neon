--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午1:58
-- To change this template use File | Settings | File Templates.
--


require("neon.utils")

local M = neon.class("View", function()
    return cc.Layer:create()
end)

function M:ctor(rootView)
    self.rootView = rootView
    self.rootView:addChild(self)
end

return M
