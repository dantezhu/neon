local M = class("Log")

M.DEBUG = 1;
M.INFO = 2;
M.WARN = 3;
M.ERROR = 4;

M._level = M.DEBUG;

function M:debug(fmt, ...)
    if(self._level > self.DEBUG) then return end
    self:log("DEBUG", fmt, ...)
end

function M:info(fmt, ...)
    if(self._level > self.INFO) then return end
    self:log("INFO", fmt, ...)
end

function M:warn(fmt, ...)
    if(self._level > self.WARN) then return end
    self:log("WARN", fmt, ...)
end

function M:error(fmt, ...)
    if(self._level > self.ERROR) then return end
    self:log("ERROR", fmt, ...)
end

function M:log(level_str, fmt, ...)
    local t = {
        string.format("[%s]", level_str),
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
