//
//  startWith_merge_zip结合操作符.swift
//  LearnSwift
//
//  Created by admin on 2020/9/7.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class startWith_merge_zip_____: NSObject {

    /*
     1，startWith
     （1）基本介绍
     该方法会在 Observable 序列开始之前插入一些事件元素。即发出事件消息之前，会先发出这些预先插入的事件消息。
     2，merge
     （1）基本介绍
     该方法可以将多个（两个或两个以上的）Observable 序列合并成一个 Observable 序列。
     
     
     3，zip
     （1）基本介绍
     该方法可以将多个（两个或两个以上的）Observable 序列压缩成一个 Observable 序列。
     而且它会等到每个 Observable 事件一一对应地凑齐之后再合并。
     
     附：zip 常常用在整合网络请求上。
     比如我们想同时发送两个请求，只有当两个请求都成功后，再将两者的结果整合起来继续往下处理。这个功能就可以通过 zip 来实现。

     
     4，combineLatest
     （1）基本介绍
     该方法同样是将多个（两个或两个以上的）Observable 序列元素进行合并。
     但与 zip 不同的是，每当任意一个 Observable 有新的事件发出时，它会将每个 Observable 序列的最新的一个事件元素进行合并。
     
     
     5，withLatestFrom
     （1）基本介绍
     该方法将两个 Observable 序列合并为一个。每当 self 队列发射一个元素时，便从第二个序列中取出最新的一个值。
     
     
     6，switchLatest
     （1）基本介绍
     switchLatest 有点像其他语言的 switch 方法，可以对事件流进行转换。
     比如本来监听的 subject1，我可以通过更改 variable 里面的 value 更换事件源。变成监听 subject2。
     
     
     
     
     **/
}
