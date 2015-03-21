local M = class("Logger")

function M:ctor()
    self._level = neon.logging.DEBUG;
    self.handlers = {}
end

function M:debug(msg, ...)
    self:log(neon.logging.DEBUG, msg, ...)
end

function M:info(msg, ...)
    self:log(neon.logging.INFO, msg, ...)
end

function M:warn(msg, ...)
    self:log(neon.logging.WARN, msg, ...)
end

function M:error(msg, ...)
    self:log(neon.logging.ERROR, msg, ...)
end

function M:critical(msg, ...)
    self:log(neon.logging.CRITICAL, msg, ...)
end

function M:fatal(msg, ...)
    self:critical(msg, ...)
end

function M:log(level, msg, ...)
    if (self._level > level) then 
        return 
    end

    local t = {
        string.format("[%s]", neon.logging.LEVEL_DESC[level]),
        " ",
        string.format(tostring(msg), ...)
    }

    record = table.concat(t)

    self:handle(level, record)
end

function M:getLevel()
    return self._level
end

function M:setLevel(level)
    self._level = level
end

function M:addHandler(handler)
    table.insert(self.handlers, handler)
end

function M:removeHandler(handler)
    for idx,val in ipairs(self.handlers) do
        if handler == val then
            self.handlers[idx] = nil
        end
    end
end

function M:handle(level, record)
    for idx,handler in ipairs(self.handlers) do
        handler:handle(level, record)
    end
end

return M
