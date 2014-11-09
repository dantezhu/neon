
require("neon.init")
local ViewClass = neon.import(".View")


local M = neon.class("LoadingController", neon.Controller)

function M:getViewClass()
    return ViewClass
end


function M:initAppEvents()
    self:addAppEvent(EVT.show_loading, neon.handler(self, self.showSelf))
end

function M:showSelf(from)
    print(from)
    self:show()
end

return M