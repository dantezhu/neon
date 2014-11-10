
require("neon.init")

local M = neon.class("LoadingController", neon.Controller)

M.name = "loading"
M.viewClass = neon.import(".View")

function M:onCreate()
    neon.events:addHandler(EVT.show_loading, neon.handler(self, self.showSelf), self)
end

function M:showSelf(name, from)
    print(name, from)
    self:show()
end

return M
