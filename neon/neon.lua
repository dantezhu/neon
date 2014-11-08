require("neon.utils")

local M = neon.class("Neon")

function M:ctor(scene)
    self.scene = scene
    -- modules列表
    self.modules = {}
end

-- 启动
function M:run()
    local blueprint = self.blueprints[bp_name]

    if blueprint ~= nil then
        blueprint:show()
    end
end

function register_module(controller)
    blueprint.register_to_app(self)
end

return M
