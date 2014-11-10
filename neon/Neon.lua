require("neon.utils")
require "Cocos2d"

local M = neon.class("Neon")

function M:ctor()
    self.scene = nil
    -- controllers列表
    self.controllers = {}
end

-- 启动
function M:run(controllerName)
    self.scene = cc.Scene:create()

    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(self.scene)
    else
        cc.Director:getInstance():runWithScene(self.scene)
    end

    local controller = self:getController(controllerName)
    if controller ~= nil then
        controller:show()
    end
end

function M:registerController(controllerClass)
    local controller = controllerClass.new(self)

    self.controllers[controller.name] = controller
end

function M:getController(name)
	return self.controllers[name]
end

return M
