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

function M:ctor()
    self:getRoot():addChild(self)
end
function M:getRoot()
    neon.loge("-- you must overite this method !", self.__cname)
    return nil
end

return M
