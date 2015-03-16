--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午11:06
-- To change this template use File | Settings | File Templates.
--

-- log相关
function neon.logd(msg,tag) 
    neon.logger:d(msg,tag) 
end

function neon.logi(msg,tag) 
    neon.logger:i(msg,tag) 
end

function neon.logw(msg,tag) 
    neon.logger:w(msg,tag) 
end

function neon.loge(msg,tag) 
    neon.logger:e(msg,tag) 
end
