
# Neon

## 一、简介

MVC Framework

已支持cocos2dx+lua平台，后续会支持更多平台。

## 二、设计说明

1. events
    events使用了最简单的同步消息处理，没有异步、批量、锁保护等复杂的功能。
    如果在实际使用中需要用到这些功能，可以封装一个EventBus库，负责缓存events、线程同步、以及定时批量处理的能力。
