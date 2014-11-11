--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午10:24
-- To change this template use File | Settings | File Templates.
--

neon = neon or {}

require("neon.utils")

neon.View = require("neon.View")
neon.EventDispatcher = require("neon.EventDispatcher")
neon.Neon = require("neon.Neon")

-- events是可以跨app的
neon.events = neon.EventDispatcher.new()
