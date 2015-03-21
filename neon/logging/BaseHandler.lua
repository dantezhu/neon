local M = class("BaseHander")

function M:ctor()
    self._level = neon.logging.DEBUG;
end

function M:getLevel()
    return self._level
end

function M:setLevel(level)
    self._level = level
end

function M:handle(level, msg)
    if (self._level > level) then 
        return 
    end
    
    record = self:format(level, msg)
    self:emit(record)
end

function M:format(level, msg)
    -- 可以继承重写
    return string.format("[%s] %s",
        neon.logging.LEVEL_DESC[level],
        msg
    )
end

function M:emit(record)
    -- 继承重写
end

return M
