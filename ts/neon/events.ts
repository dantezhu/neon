type Callback = (...args: any[]) => void;

// Callback的容器
interface Handler {
    callback: Callback,
    target: any,
}

export class Events {
    // 事件及处理函数
    private _eventTable: {[key:string]: Handler[]};

    constructor() {
        this._eventTable = {};
    }

    // 添加
    addHandler(name: string, callback: Callback, target: any) {
        if (target === null) {
            throw new Error('target cannot be null');
        }

        if (!(name in this._eventTable)) {
            this._eventTable[name] = []
        }

        let found = false;

        // 判断是否已经存在
        for (let handler of this._eventTable[name]) {
            if (handler.callback === callback && handler.target === target) {
                found = true;
                break;
            }
        }

        if (!found) {
            this._eventTable[name].push({
                callback: callback,
                target: target,
            })
        }
    }

    // 删除
    delHandler(name: string, callback: Callback) {
        if (!(name in this._eventTable)) {
            return;
        }

        let handlers = this._eventTable[name]

        for (let i = 0; i < handlers.length; i++) {
            if (handlers[i].callback === callback) {
                // 找到了，删掉
                handlers.splice(i, 1);
                // 因为删除元素后，当前索引位置的元素已经变为下一个元素，所以需要减一
                i--; 
            }
        }
    }

    // 通过target删除
    delHandlersForTarget(target: any) {
        Object.entries(this._eventTable).forEach(([name, handlers]) => {

            for (let i = 0; i < handlers.length; i++) {
                if (handlers[i].target === target) {
                    // 找到了，删掉
                    handlers.splice(i, 1);
                    // 因为删除元素后，当前索引位置的元素已经变为下一个元素，所以需要减一
                    i--;
                }
            }

        });
    }

    // 删除对应name
    delHandlers(name: string) {
        delete this._eventTable[name];
    }

    // 清空
    clearHandlers() {
        this._eventTable = {};
    }

    // 触发事件
    emit(name: string, ...args: any[]) {
        if (!(name in this._eventTable)) {
            return;
        }

        // 浅copy，避免在事件处理函数中添加或删除事件处理函数
        let handlers = this._eventTable[name].slice();

        for (let handler of handlers) {
            if (this._eventTable[name].indexOf(handler) === -1) {
                // 说明可能在过程中被移除了
                // 如果继续调用可能会报错
                continue;
            }

            handler.callback(...args);
        }
    }
}