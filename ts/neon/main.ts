import {Events} from './events'
import {Logger, LogLevel, logger} from './logging'

function cb1(event: string, ...args: any[]) {
    logger.verbose('cb1', event, ...args);
}

function cb2(event: string, ...args: any[]) {
    logger.verbose('cb2', event, ...args);
}

function testLogger() {
    logger.verbose('I am verbose');
    logger.info('I am info');
    logger.warn('I am warn');
    logger.error('I am error');
}

function testEvents() {

    logger.error('--- testEvents');

    const events = new Events();

    let a = new Object();
    let b = new Object();
    let c = new Object();

    events.addHandler('open', function (...args: any[]) {
        logger.verbose(...args)
    }, a)

    events.addHandler('close', function (...args: any[]) {
        logger.verbose(...args)
    }, a)

    events.addHandler('show', function (...args: any[]) {
        logger.verbose(...args)
    }, b)

    events.addHandler('hide', function (...args: any[]) {
        logger.verbose(...args)
    }, b)

    events.addHandler('test1', cb1, c);
    events.addHandler('test1', cb2, c);
    events.addHandler('test2', cb1, c);
    events.addHandler('test2', cb2, c);

    logger.verbose('--- start dispatch event')

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')
    events.emit('test1', 'main', '2')
    events.emit('test1', 'login', '2')
    events.emit('test2', 'main', '2')
    events.emit('test2', 'login', '2')

    logger.verbose('--- after delHandlers for a')
    events.delHandlersForTarget(a)

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')
    events.emit('test1', 'main', '2')
    events.emit('test1', 'login', '2')
    events.emit('test2', 'main', '2')
    events.emit('test2', 'login', '2')

    logger.verbose('--- after delHandler for cb1')
    events.delHandler('test1', cb1)

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')
    events.emit('test1', 'main', '2')
    events.emit('test1', 'login', '2')
    events.emit('test2', 'main', '2')
    events.emit('test2', 'login', '2')

    logger.verbose('--- after delHandlers for test2')
    events.delHandlers('test2')

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')
    events.emit('test1', 'main', '2')
    events.emit('test1', 'login', '2')
    events.emit('test2', 'main', '2')
    events.emit('test2', 'login', '2')

    logger.verbose('--- after clearHandlers');
    events.clearHandlers()

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')
    events.emit('test1', 'main', '2')
    events.emit('test1', 'login', '2')
    events.emit('test2', 'main', '2')
    events.emit('test2', 'login', '2')

}

function testBatchEvents() {

    logger.error('--- testBatchEvents');

    const events = new Events(true);

    let a = new Object();
    let b = new Object();
    let c = new Object();

    events.addHandler('open', function (...args: any[]) {
        logger.verbose(...args)
    }, a)

    events.addHandler('close', function (...args: any[]) {
        logger.verbose(...args)
    }, a)

    events.addHandler('show', function (...args: any[]) {
        logger.verbose(...args)
    }, b)

    events.addHandler('hide', function (...args: any[]) {
        logger.verbose(...args)
    }, b)

    events.addHandler('test1', cb1, c);
    events.addHandler('test1', cb2, c);
    events.addHandler('test2', cb1, c);
    events.addHandler('test2', cb2, c);

    logger.verbose('--- start dispatch event')

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')
    events.emit('test1', 'main', '2')
    events.emit('test1', 'login', '2')
    events.emit('test2', 'main', '2')
    events.emit('test2', 'login', '2')

    events.processEvents();
}

// testLogger()
testEvents()
testBatchEvents()
