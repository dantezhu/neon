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
function M:addHandler(name, callback, target)
    if self._eventTable[name] == nil then
        self._eventTable[name] = {}
    end

    local found = false

    for idx,val in ipairs(self._eventTable[name]) do
        if val.callback == callback then
            found = true
        end
    end

    if not found then
        table.insert(self._eventTable[name], {
                callback=callback,
                target=target,
        })
    end
end

-- 删除
function M:delHandler(name, callback)
    for name,handlers in pairs(self._eventTable) do
        for idx,handler in ipairs(handlers) do
            if handler.callback == callback then
                -- 删除即清空
                handlers[idx] = nil
            end
        end
    end
end

-- 通过target删除
function M:delHandlersForTarget(target)
    for name,handlers in pairs(self._eventTable) do
        for idx,handler in ipairs(handlers) do
            if handler.target == target then
                -- 删除即清空
                handlers[idx] = nil
            end
        end
    end
end

-- 删除对应name
function M:delHandlers(name)
    self._eventTable[name] = nil
end

-- 触发
function M:postEvent(name, ...)
    if self._eventTable[name] == nil then
        return
    end

    local handlers = {}
    for idx,handler in ipairs(self._eventTable[name]) do
        table.insert(handlers, handler)
    end

    for idx,handler in ipairs(handlers) do
        local found = false
        if self._eventTable[name] ~= nil then
            for idx,val in ipairs(self._eventTable[name]) do
                if val == handler then
                    found = true
                end
            end
        end

        if found then
            handler.callback(...)
        end
    end
end

return M
