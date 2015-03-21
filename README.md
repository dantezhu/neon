neon
====

#### 一. 简介

lua 类mvc framework，支持 cocos2dx-3.4

基本模块包括: Neon, View, Events, Logger

分别功能如下:

* Neon

    代码使用 app - 多views 的方式

    每个app绑定一个scene，即生命周期与scene一致

    每个view相当于一个layer，上面可以进行任意的展示.

    一般小游戏，单个app就足够了，不同页面使用view来实现即可。如果涉及大型游戏，需要多个app也是可以的.

* View
    
    上文提到的View

* Events

    事件通知
    默认的 neon.events 是跨app的

* Logger

    日志。默认有 neon.logger

#### 二. 使用说明

* 继承Neon后最主要的函数是 onRun(params)
* 继承View后，最主要的函数是 onRender(params)
