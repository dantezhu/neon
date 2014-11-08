require("neon.utils")

local M = neon.class("Neon")

function M:ctor(scene)
    self.scene = scene
    -- modules列表
    self.modules = {}
end

-- 启动
function M:run()
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(self.scene)
    else
        cc.Director:getInstance():runWithScene(self.scene)
    end
end

function M:register_module(name, controller)
    controller:register_to_app(self, name)
end

function M:get_module(name)
    return self.modules[name]
end

return M
