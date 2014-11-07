#!/usr/bin/env lua

--=============================================================================
--
--     FileName: main.lua
--         Desc: 
--
--       Author: dantezhu
--        Email: zny2008@gmail.com
--     HomePage: http://www.vimer.cn
--
--      Created: 2014-11-07 17:01:42
--      Version: 0.0.1
--      History:
--               0.0.1 | dantezhu | 2014-11-07 17:01:42 | init
--
--=============================================================================

package.path = string.format("%s;%s", "../../?.lua", package.path)

require("neon.init")

local function sleep(sec)
   os.execute("sleep " .. sec)
end

local function process()
    while 1 do
        print (1)
        sleep(1)
    end
end

local function main()
    process()
end

main()
