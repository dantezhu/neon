neon
====

#### 一. 简介

Lua MVVM Framework，支持 cocos2dx-3.4

基本模块包括: Neon, View, Events, Logger

分别功能如下:

* Neon

    代码使用 app - 多views 的方式

    每个app绑定一个scene，即生命周期与scene一致

    每个view相当于一个layer，上面可以进行任意的展示.

    一般小游戏，单个app就足够了，不同页面使用view来实现即可。如果涉及大型游戏，需要多个app也是可以的.

* View

    这里的View，实际是ViewModel，真实的View是Cocos提供的Layer。

    只是在本框架中，为了使用方便，直接将ViewModel命名为了View。

    ViewModel是View与Model的桥梁。

* Events

    事件通知
    默认的 neon.events 是跨app的

* Logger

    日志。默认有 neon.logger

#### 二. 使用说明

* 继承Neon后最主要的函数是 onRun(params)
* 继承View后，最主要的函数是 onRender(params)


view 区分 onCreate 和 onRender(params) 的好处在于，onCreate可以处理那些与传入数据没关系的，而onRender则是与数据有关，比如flask的render_template。

另一方面，把所有展示逻辑都放在onCreate里面也不太好，毕竟createView调用了onCreate时，还没有将生成的view放到app.views里面。而用onRender可以弥补这个不足。
