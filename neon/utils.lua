--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午11:06
-- To change this template use File | Settings | File Templates.
--

-- log相关
function neon.logd(msg,tag) 
    neon.logger:debug(msg,tag) 
end

function neon.logi(msg,tag) 
    neon.logger:info(msg,tag) 
end

function neon.logw(msg,tag) 
    neon.logger:warn(msg,tag) 
end

function neon.loge(msg,tag) 
    neon.logger:error(msg,tag) 
end
