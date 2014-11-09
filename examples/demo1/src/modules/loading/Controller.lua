
require("neon.init")

local M = neon.class("LoadingController", neon.Controller)

M.name = "loading"
M.viewClass = neon.import(".View")

function M:onCreate()
    self:addAppEvent(EVT.show_loading, neon.handler(self, self.showSelf))
end

function M:showSelf(from)
    print(from)
    self:show()
end

return M
