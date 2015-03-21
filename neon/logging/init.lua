neon.logging = neon.logging or {}

neon.logging.DEBUG = 1
neon.logging.INFO = 2
neon.logging.WARNING = 3
neon.logging.ERROR = 4
neon.logging.CRITICAL = 5

LEVEL_DESC = {}
LEVEL_DESC[neon.logging.DEBUG] = "DEBUG"
LEVEL_DESC[neon.logging.INFO] = "INFO"
LEVEL_DESC[neon.logging.WARNING] = "WARNING"
LEVEL_DESC[neon.logging.ERROR] = "ERROR"
LEVEL_DESC[neon.logging.CRITICAL] = "CRITICAL"

neon.logging.LEVEL_DESC = LEVEL_DESC

neon.logging.Logger = require("neon.logging.Logger")

neon.logging.BaseHandler = require("neon.logging.BaseHandler")
neon.logging.StreamHandler = require("neon.logging.StreamHandler")
