
require("neon.init")

local M = neon.class("LoadingController", neon.Controller)

M.name = "loading"
M.viewClass = neon.import(".View")

function M:onCreate()
    neon.events:addHandler(EVT.show_loading, neon.handler(self, self.showSelf), nil)
end

function M:onCreateView()
    neon.loge("loading onCreateView")
    neon.events:addHandler(EVT.test, function ()
    end, self)
    
end
function M:onDestroyView()
    neon.loge("loading onDestroyView")
    neon.events:delHandlersForTarget(self)
end

function M:showSelf(from)
    print(from)
    self:show()
end

return M
