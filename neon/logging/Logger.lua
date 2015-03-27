local M = class("Logger")

function M:ctor()
    self._level = neon.logging.DEBUG;
    self.handlers = {}
end

function M:debug(fmt, ...)
    self:_log(neon.logging.DEBUG, fmt, ...)
end

function M:info(fmt, ...)
    self:_log(neon.logging.INFO, fmt, ...)
end

function M:warning(fmt, ...)
    self:_log(neon.logging.WARNING, fmt, ...)
end

function M:error(fmt, ...)
    self:_log(neon.logging.ERROR, fmt, ...)
end

function M:critical(fmt, ...)
    self:_log(neon.logging.CRITICAL, fmt, ...)
end

function M:fatal(fmt, ...)
    self:_log(neon.logging.CRITICAL, fmt, ...)
end

function M:_log(level, fmt, ...)
    -- 外界不能调用
    if (self._level > level) then 
        return 
    end

    local record = {
        level=level,
        -- 变化调用层级的话，修改第一个3
        caller=self:trimString(self:splitString(debug.traceback("", 3), "\n")[3]),
        msg=string.format(fmt, ...),
    }

    self:handle(record)
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

function M:handle(record)
    for idx,handler in ipairs(self.handlers) do
        handler:handle(record)
    end
end

function M:splitString(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

function M:trimString(input)
    input = string.gsub(input, "^[ \t\n\r]+", "")
    return string.gsub(input, "[ \t\n\r]+$", "")
end

return M
