//
//  delay、materialize、timeou其它操作符.swift
//  LearnSwift
//
//  Created by admin on 2020/9/7.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class delay_materialize_timeou_____: NSObject {

    /**
     1，delay
     （1）基本介绍
     该操作符会将 Observable 的所有元素都先拖延一段设定好的时间，然后才将它们发送出来。


     2，delaySubscription
     （1）基本介绍
     使用该操作符可以进行延时订阅。即经过所设定的时间后，才对 Observable 进行订阅操作。


     3，materialize
     （1）基本介绍
     该操作符可以将序列产生的事件，转换成元素。
     通常一个有限的 Observable 将产生零个或者多个 onNext 事件，最后产生一个 onCompleted 或者 onError 事件。而 materialize 操作符会将 Observable 产生的这些事件全部转换成元素，然后发送出来。
     
     
     4，dematerialize
     （1）基本介绍
     该操作符的作用和 materialize 正好相反，它可以将 materialize 转换后的元素还原。
     
     
     5，timeout
     （1）基本介绍
     使用该操作符可以设置一个超时时间。如果源 Observable 在规定时间内没有发任何出元素，就产生一个超时的 error 事件。

     6，using
     （1）基本介绍
     使用 using 操作符创建 Observable 时，同时会创建一个可被清除的资源，一旦 Observable 终止了，那么这个资源就会被清除掉了。


     */
}
