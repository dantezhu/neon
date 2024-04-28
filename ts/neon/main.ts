import {Events} from './events'
import {Logger, LogLevel} from './logging'

let events = new Events()
let logger = new Logger();

function cb1(...args: any[]) {
    logger.debug('cb1', ...args);
}

function cb2(...args: any[]) {
    logger.debug('cb2', ...args);
}

function testEvents() {


    logger.setLevel(LogLevel.DEBUG);

    logger.verbose('I am verbose');
    logger.debug('I am debug');
    logger.info('I am info');
    logger.warn('I am warn');
    logger.error('I am error');

    let a = new Object();
    let b = new Object();
    let c = new Object();

    events.addHandler('open', function (...args: any[]) {
        logger.debug(...args)
    }, a)

    events.addHandler('close', function (...args: any[]) {
        logger.debug(...args)
    }, a)

    events.addHandler('show', function (...args: any[]) {
        logger.debug(...args)
    }, b)

    events.addHandler('hide', function (...args: any[]) {
        logger.debug(...args)
    }, b)

    events.addHandler('test1', cb1, c);
    events.addHandler('test1', cb2, c);
    events.addHandler('test2', cb1, c);
    events.addHandler('test2', cb2, c);

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')
    events.emit('test1', 'main', '2')
    events.emit('test1', 'login', '2')
    events.emit('test2', 'main', '2')
    events.emit('test2', 'login', '2')

    events.delHandlersForTarget(a)
    logger.debug('after delHandlers for a')

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')
    events.emit('test1', 'main', '2')
    events.emit('test1', 'login', '2')
    events.emit('test2', 'main', '2')
    events.emit('test2', 'login', '2')

    events.delHandler('test1', cb1)
    logger.debug('after delHandler for cb1')

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')
    events.emit('test1', 'main', '2')
    events.emit('test1', 'login', '2')
    events.emit('test2', 'main', '2')
    events.emit('test2', 'login', '2')

    events.delHandlers('test2')
    logger.debug('after delHandlers for test2')

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')
    events.emit('test1', 'main', '2')
    events.emit('test1', 'login', '2')
    events.emit('test2', 'main', '2')
    events.emit('test2', 'login', '2')

    events.clearHandlers()
    logger.debug('after clearHandlers');

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')
    events.emit('test1', 'main', '2')
    events.emit('test1', 'login', '2')
    events.emit('test2', 'main', '2')
    events.emit('test2', 'login', '2')

}

testEvents()