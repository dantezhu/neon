
require("neon.init")

local M = neon.class("LoadingController", neon.Controller)

M.name = "loading"
M.viewClass = neon.import(".View")

function M:onCreate()
    neon.events:addHandler(EVT.show_loading, neon.handler(self, self.showSelf), self)
end

function M:onCreateView()
    neon.loge("loading onCreateView")
    neon.events:addHandler(EVT.test, function (name)
        
    end, self)
    
end
function M:onDestoryView()
    neon.loge("loading onDestoryView")
    neon.events:delHandlersForTarget(self)
end

function M:showSelf(name, from)
    print(name, from)
    self:show()
end

return M
