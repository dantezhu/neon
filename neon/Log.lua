local M = class("Log")

M.DEBUG = 1;
M.INFO = 2;
M.WARN = 3;
M.ERROR = 4;

M._level = M.DEBUG;

function M:d(fmt, ...)
    if(self._level > self.DEBUG) then return end
    self:log("DEBUG", fmt, ...)
end

function M:i(fmt, ...)
    if(self._level > self.INFO) then return end
    self:log("INFO", fmt, ...)
end

function M:w(fmt, ...)
    if(self._level > self.WARN) then return end
    self:log("WARN", fmt, ...)
end

function M:e(fmt, ...)
    if(self._level > self.ERROR) then return end
    self:log("ERROR", fmt, ...)
end

function M:log(level, fmt, ...)
    local t = {
        string.format("[%s]", level),
        " ",
        string.format(tostring(fmt), ...)
    }
    print(table.concat(t))
end

function M:setLevel(level)
    if level < self.DEBUG or level > self.ERROR then 
       self:e("error on setLevel ---" ,"M")
       return
    end
    
    self._level = level
end

return M
