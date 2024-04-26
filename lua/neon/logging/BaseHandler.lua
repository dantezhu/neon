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

function M:handle(record)
    if (self._level > record.level) then 
        return 
    end
    
    self:emit(record)
end

function M:format(record)
    -- 可以继承重写
    return string.format("\n%s\n[%s][%s]:\n%s\n%s",
        "/--------------------------------------------------------------------------------",
        neon.logging.LEVEL_DESC[record.level],
        record.caller,
        record.msg,
        "--------------------------------------------------------------------------------/"
    )
end

function M:emit(record)
    -- 继承重写
end

return M
