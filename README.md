
# Neon

## 一、简介

MVC Framework

已支持cocos2dx+lua平台，后续会支持更多平台。

## 二、设计说明

1. events
    events支持两种消息处理模式：单个和批量(仅TS)，但没有考虑线程同步等复杂的情况。
    如果在实际使用中需要用到这些功能，可以封装一个EventBus库，负责线程同步等能力。
