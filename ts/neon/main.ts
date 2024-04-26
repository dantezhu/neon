import {Events} from './events'
import {Logger, LogLevel} from './logging'

function testEvents() {

    let events = new Events()
    let logger = new Logger();

    logger.setLevel(LogLevel.DEBUG);

    logger.verbose('I am verbose');
    logger.debug('I am debug');
    logger.info('I am info');
    logger.warn('I am warn');
    logger.error('I am error');

    let a = new Object();
    let b = new Object();

    events.addHandler('open', function (...args: any[]) {
        logger.debug('open', ...args)
    }, a)

    events.addHandler('close', function (...args: any[]) {
        logger.debug('close', ...args)
    }, a)

    events.addHandler('show', function (...args: any[]) {
        logger.debug('show', ...args)
    }, b)

    events.addHandler('hide', function (...args: any[]) {
        logger.debug('hide', ...args)
    }, b)

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')

    events.delHandlersForTarget(a)
    logger.debug('after delHandlers for a')

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')

    events.clearHandlers()
    logger.debug('after clearHandlers');

    events.emit('open', 'main', '1')
    events.emit('close', 'login', '1')
    events.emit('show', 'main', '1')
    events.emit('hide', 'login', '1')

}

testEvents()