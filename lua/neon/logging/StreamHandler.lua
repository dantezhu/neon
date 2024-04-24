local M = class("StreamHander", neon.logging.BaseHandler)

function M:emit(record)
    print(self:format(record))
end

return M
