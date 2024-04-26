require("json")

local M = class("HttpLogHandler", neon.logging.BaseHandler)

function M:emit(record)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    xhr:open("POST", "http://127.0.0.1:5000/log")

    local function onReadyStateChange()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            local response   = xhr.response
            print(response)
            -- local output = json.decode(response,1)
            -- table.foreach(output,function(i, v) print (i, v) end)
            -- print("headers are")
            -- table.foreach(output.headers,print)
        else
            print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
    end

    xhr:registerScriptHandler(onReadyStateChange)
    local postData = json.encode({
            record=record
    })
    -- Content-Type: application/x-www-form-urlencoded
    -- 默认是上面的值，会导致服务器按照form去解析
    xhr:setRequestHeader("Content-Type", "")
    xhr:send(postData)
end

return M
