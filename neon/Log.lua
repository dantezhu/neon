local M = neon.class("Log")

M.DEBUG = 4;
M.INFO = 3;
M.WARN = 2;
M.ERROR = 1;

M.level = M.DEBUG;

function M:ctor(args) 

end

function M:d(msg,tag)
    tag = tag or "unkown"
    msg = msg or "unkown"
    if(self.level < self.DEBUG) then return end
    print("[DEBUG - "..tag.."] : " .. msg)
end

function M:i(msg,tag)
    tag = tag or "unkown"
    msg = msg or "unkown"
    if(self.level < self.INFO) then return end
    print("[INFO - "..tag.."] : " .. msg)
end

function M:w(msg,tag)
    tag = tag or "unkown"
    msg = msg or "unkown"
    if(self.level < self.WARN) then return end
    print("[WARN - "..tag.."] : " .. msg)
end

function M:e(msg,tag)
    tag = tag or "unkown"
    msg = msg or "unkown"
    if(self.level < self.ERROR) then return end
    print("[ERROR - "..tag.."] : " .. msg)
end


function M:setMLvl(parameters)
    if parameters > self.DEBUG and parameters < self.ERROR then 
       self:e("error on setMLvl ---" ,"M")
       return
    end
    
    self.level = parameters
end

return M
