export enum LogLevel {
    VERBOSE,
    DEBUG,
    INFO,
    WARN,
    ERROR,
}

const levelNameMap = new Map<LogLevel, string> ([
    [LogLevel.VERBOSE, 'VERBOSE'],
    [LogLevel.DEBUG, 'DEBUG'],
    [LogLevel.INFO, 'INFO'],
    [LogLevel.WARN, 'WARN'],
    [LogLevel.ERROR, 'ERROR'],
]);

export class Logger {
    private _level: LogLevel = LogLevel.VERBOSE;

    setLevel(level: LogLevel) {
        this._level = level;
    }

    getLevel(): LogLevel {
        return this._level;
    }

    verbose(...args: any[]) {
        this._log(LogLevel.VERBOSE, ...args);
    }

    debug(...args: any[]) {
        this._log(LogLevel.DEBUG, ...args);
    }

    info(...args: any[]) {
        this._log(LogLevel.INFO, ...args);
    }

    warn(...args: any[]) {
        this._log(LogLevel.WARN, ...args);
    }

    error(...args: any[]) {
        this._log(LogLevel.ERROR, ...args);
    }

    private _formatTime(now: Date): string {
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1).padStart(2, '0'); // 月份从0开始，需加1并补零
        const day = String(now.getDate()).padStart(2, '0');
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const seconds = String(now.getSeconds()).padStart(2, '0');
        const milliseconds = String(now.getMilliseconds()).padStart(3, '0');
    
        return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}.${milliseconds}`;
    }

    private _log(level: LogLevel, ...args: any[]) {
        if (level < this._level) {
            return;
        }

        let prefix = this._makePrefix(level);

        switch(level) {
            case LogLevel.VERBOSE:
                console.log(prefix, ...args);
                break;
            case LogLevel.DEBUG:
                console.debug(prefix, ...args);
                break;
            case LogLevel.INFO:
                console.info(prefix, ...args);
                break;
            case LogLevel.WARN:
                console.warn(prefix, ...args);
                break;
            case LogLevel.ERROR:
                console.error(prefix, ...args);
                break;
        }
    }

    private _makePrefix(level: LogLevel): string {
        let now = this._formatTime(new Date());
        let levelName = levelNameMap.get(level);
        return `[${now}][${levelName}]`
    }

}