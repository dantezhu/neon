require("neon.utils")
require "Cocos2d"

local M = neon.class("Neon")

function M:ctor()
    self.scene = nil
    -- controllers列表
    self.controllers = {}
end

-- 启动
function M:run(moduleName, scene)
    if scene == nil then
        self.scene = cc.Scene:create()
    else
        self.scene = scene
    end

    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(self.scene)
    else
        cc.Director:getInstance():runWithScene(self.scene)
    end
    
    self:openModule(moduleName)

end

function M:addModule(controllerClass)
    local controller = controllerClass.new(self)
    
    self.controllers[controller.name] = controller
end

function M:getModule(name)
    return self.controllers[name]
end

function M:openModule(name)
    if self:getModule(name) ~= nil then
       self:getModule(name):show()
    end
end

function M:closeModule(name)
    if self:getModule(name) ~= nil then
        self:getModule(name):remove()
    end
end

function M:hideModule(name)
    if self:getModule(name) ~= nil then
        self:getModule(name):hide()
    end
end

return M
