type Callback = (event: string, ...args: any[]) => void;

// Callback的容器
interface Handler {
    callback: Callback,
    target: any,
}

export class Events {
    // 事件及处理函数
    private _eventTable: Map<string, Handler[]>;

    constructor() {
        this._eventTable = new Map<string, Handler[]>();
    }

    // 添加
    addHandler(name: string, callback: Callback, target: any) {
        if (target === null) {
            throw new Error('target cannot be null');
        }

        if (!(this._eventTable.has(name))) {
            this._eventTable.set(name, [])
        }

        let handlers = this._eventTable.get(name) || [];

        let found = false;

        // 判断是否已经存在
        for (let handler of handlers) {
            if (handler.callback === callback && handler.target === target) {
                found = true;
                break;
            }
        }

        if (!found) {
            handlers.push({
                callback: callback,
                target: target,
            })
        }
    }

    // 删除
    delHandler(name: string, callback: Callback) {
        if (!(this._eventTable.has(name))) {
            return;
        }

        let handlers = this._eventTable.get(name) || [];

        for (let i = 0; i < handlers.length; i++) {
            if (handlers[i].callback === callback) {
                // 找到了，删掉
                handlers.splice(i, 1);
                // 因为删除元素后，当前索引位置的元素已经变为下一个元素，所以需要减一
                i--; 
            }
        }

        if (handlers.length === 0) {
            this._eventTable.delete(name);
        }
    }

    // 通过target删除
    delHandlersForTarget(target: any) {
        let keysToDelete:string[] = [];

        this._eventTable.forEach((handlers, name) => {

            for (let i = 0; i < handlers.length; i++) {
                if (handlers[i].target === target) {
                    // 找到了，删掉
                    handlers.splice(i, 1);
                    // 因为删除元素后，当前索引位置的元素已经变为下一个元素，所以需要减一
                    i--;
                }
            }

            if (handlers.length === 0) {
                keysToDelete.push(name);
            }

        });

        if (keysToDelete.length > 0) {
            keysToDelete.forEach(key => {
                this._eventTable.delete(key);
            })
        }
    }

    // 删除对应name
    delHandlers(name: string) {
        this._eventTable.delete(name);
    }

    // 清空
    clearHandlers() {
        this._eventTable.clear()
    }

    // 触发事件
    emit(name: string, ...args: any[]) {
        if (!(this._eventTable.has(name))) {
            return;
        }

        // 浅copy，避免在事件处理函数中添加或删除事件处理函数
        let handlers = (this._eventTable.get(name) || []).slice();

        for (let handler of handlers) {
            if ((this._eventTable.get(name) || []).indexOf(handler) === -1) {
                // 说明可能在过程中被移除了
                // 如果继续调用可能会报错
                continue;
            }

            handler.callback(name, ...args);
        }
    }
}

export const events = new Events();