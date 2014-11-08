--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午11:51
-- To change this template use File | Settings | File Templates.
--

require("neon.utils")


local M = neon.class("EventDispatcher")

function M:ctor()
    self._eventTable = {}
end

-- 覆盖
function M:register(name, callback)
    self._eventTable[name] = callback
end

-- 删除
function M:unregister(name)
    self._eventTable[name] = nil
end

-- 触发
function M:post(name, params)
    local callback = self._eventTable[name]
    if callback ~= nil then
        return callback(params)
    else
        return nil
    end
end

return M
