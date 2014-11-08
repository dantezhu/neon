--
-- Created by IntelliJ IDEA.
-- User: dantezhu
-- Date: 14-11-7
-- Time: 上午10:24
-- To change this template use File | Settings | File Templates.
--

neon = neon or {}

require("neon.utils")

neon.Controller = require("neon.controller")
neon.View = require("neon.view")
neon.EventDispatcher = require("neon.event_dispatcher")

neon.eventDispatcher = neon.EventDispatcher.new()
