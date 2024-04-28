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

    private _padStart(str: string, targetLength: number, padString: string): string {
        const len = targetLength - str.length;
        if (len <= 0) return str;
        const padding = padString.repeat(Math.ceil(len / padString.length)).slice(0, len);
        return padding + str;
    }
    private _formatTime(tm: Date): string {
        const year = tm.getFullYear();
        const month = this._padStart(String(tm.getMonth() + 1), 2, '0'); // 月份从0开始，需加1并补零
        const day = this._padStart(String(tm.getDate()), 2, '0');
        const hours = this._padStart(String(tm.getHours()), 2, '0');
        const minutes = this._padStart(String(tm.getMinutes()), 2, '0');
        const seconds = this._padStart(String(tm.getSeconds()), 2, '0');
        const milliseconds = this._padStart(String(tm.getMilliseconds()), 3, '0');
    
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

export const logger = new Logger();