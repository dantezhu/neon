local M = neon.class("Log")

M.DEBUG = 1;
M.INFO = 2;
M.WARN = 3;
M.ERROR = 4;

M._level = M.DEBUG;

function M:ctor(args) 

end

function M:d(msg,tag)
    tag = tag or "unkown"
    msg = msg or "unkown"
    if(self._level > self.DEBUG) then return end
    print("[DEBUG - "..tag.."] : " .. msg)
end

function M:i(msg,tag)
    tag = tag or "unkown"
    msg = msg or "unkown"
    if(self._level > self.INFO) then return end
    print("[INFO - "..tag.."] : " .. msg)
end

function M:w(msg,tag)
    tag = tag or "unkown"
    msg = msg or "unkown"
    if(self._level > self.WARN) then return end
    print("[WARN - "..tag.."] : " .. msg)
end

function M:e(msg,tag)
    tag = tag or "unkown"
    msg = msg or "unkown"
    if(self._level > self.ERROR) then return end
    print("[ERROR - "..tag.."] : " .. msg)
end


function M:setLevel(level)
    if level < self.DEBUG or level > self.ERROR then 
       self:e("error on setLevel ---" ,"M")
       return
    end
    
    self._level = level
end

return M
