--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午10:24
-- To change this template use File | Settings | File Templates.
--

neon = neon or {}

require("neon.logging.init")
neon.View = require("neon.View")
neon.Events = require("neon.Events")
neon.Neon = require("neon.Neon")

-- 默认logger
neon.logger = neon.logging.Logger.new()
neon.logger:addHandler(neon.logging.StreamHandler.new())
-- events是可以跨app的
neon.events = neon.Events.new()
