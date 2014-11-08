require("neon.utils")

local M = neon.class("Neon")

function M:ctor(scene)
    self.scene = scene
    -- controllers列表
    self.controllers = {}

    local EventDispatcher = require("neon.event_dispatcher")
    self.eventDispatcher = EventDispatcher.new()
end

-- 启动
function M:run()
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(self.scene)
    else
        cc.Director:getInstance():runWithScene(self.scene)
    end
end

function M:register_controller(name, controllerClass, viewClass)
    local controller = controllerClass.new(self, viewClass)

    self.controllers[name] = controller
end

function M:get_controller(name)
    return self.controllers[name]
end

return M
