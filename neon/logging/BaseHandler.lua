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

function M:handle(level, record)
    if (self._level > level) then 
        return 
    end
    
    self:emit(record)
end

function M:emit(record)
    -- 继承重写
end

return M
