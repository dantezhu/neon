local M = class("Logger")

function M:ctor()
    self._level = neon.logging.DEBUG;
    self.handlers = {}
end

function M:debug(fmt, ...)
    self:log(neon.logging.DEBUG, fmt, ...)
end

function M:info(fmt, ...)
    self:log(neon.logging.INFO, fmt, ...)
end

function M:warning(fmt, ...)
    self:log(neon.logging.WARNING, fmt, ...)
end

function M:error(fmt, ...)
    self:log(neon.logging.ERROR, fmt, ...)
end

function M:critical(fmt, ...)
    self:log(neon.logging.CRITICAL, fmt, ...)
end

function M:fatal(fmt, ...)
    self:critical(fmt, ...)
end

function M:log(level, fmt, ...)
    if (self._level > level) then 
        return 
    end

    self:handle(level, string.format(fmt, ...))
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

function M:handle(level, msg)
    for idx,handler in ipairs(self.handlers) do
        handler:handle(level, msg)
    end
end

return M
