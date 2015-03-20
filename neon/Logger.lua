local M = class("Logger")

M.DEBUG = 1;
M.INFO = 2;
M.WARN = 3;
M.ERROR = 4;

M.LEVEL_DESC = {}
M.LEVEL_DESC[M.DEBUG] = "DEBUG"
M.LEVEL_DESC[M.INFO] = "INFO"
M.LEVEL_DESC[M.WARN] = "WARN"
M.LEVEL_DESC[M.ERROR] = "ERROR"

M._level = M.DEBUG;

function M:debug(fmt, ...)
    self:log(self.DEBUG, fmt, ...)
end

function M:info(fmt, ...)
    self:log(self.INFO, fmt, ...)
end

function M:warn(fmt, ...)
    self:log(self.WARN, fmt, ...)
end

function M:error(fmt, ...)
    self:log(self.ERROR, fmt, ...)
end

function M:log(level, fmt, ...)
    if (self._level > level) then 
        return 
    end

    local t = {
        string.format("[%s]", self.LEVEL_DESC[level]),
        " ",
        string.format(tostring(fmt), ...)
    }
    print(table.concat(t))
end

function M:setLevel(level)
    if level < self.DEBUG or level > self.ERROR then 
       return false
    end
    
    self._level = level
    return true
end

return M
