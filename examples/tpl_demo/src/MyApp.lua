local M = class("MyApp", neon.Neon)

function M:onCreate()
    neon.logger:setLevel(neon.logging.DEBUG)
    
    self:registerView(require("views.MainView"))
end

function M:onRun(params)
    neon.logger:debug("onRun. params: %s", params)

    self:renderView("MainView")
end

return M
