type Handler = (...args: any[]) => void;

class Events {
    // 事件及处理函数
    private _eventTable: {[key:string]: []};

    constructor() {
        this._eventTable = {};
    }

    addHandler(name:string, callback:Handler, target:any) {
    }
}