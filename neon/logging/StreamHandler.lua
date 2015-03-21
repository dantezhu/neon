local M = class("StreamHander", neon.logging.BaseHandler)

function M:emit(record)
    print(record)
end

return M
