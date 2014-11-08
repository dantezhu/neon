require("neon.utils")

local M = neon.class("Neon")

function M:ctor(scene)
    self.scene = scene
    -- controllers列表
    self.controllers = {}
end

-- 启动
function M:run()
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(self.scene)
    else
        cc.Director:getInstance():runWithScene(self.scene)
    end
end

function M:register_controller(name, controller)
    controller:register_to_app(self, name)
end

function M:get_controller(name)
    return self.controllers[name]
end

return M
