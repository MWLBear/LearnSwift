//
//  connect、publish、replay、multicast 连接操作符.swift
//  LearnSwift
//
//  Created by admin on 2020/9/7.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class connect_publish_replay_multicast______: NSObject {

    /**
     
     1，可连接的序列
     可连接的序列（Connectable Observable）：
     （1）可连接的序列和一般序列不同在于：有订阅时不会立刻开始发送事件消息，只有当调用 connect() 之后才会开始发送值。
     （2）可连接的序列可以让所有的订阅者订阅后，才开始发出事件消息，从而保证我们想要的所有订阅者都能接收到事件消息。

     2，publish
     （1）基本介绍
     publish 方法会将一个正常的序列转换成一个可连接的序列。同时该序列不会立刻发送事件，只有在调用 connect 之后才会开始

     */
    
   static func __publish() {
            //每隔1秒钟发送1个事件
            let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
                .publish()
                     
            //第一个订阅者（立刻开始订阅）
            _ = interval
                .subscribe(onNext: { print("订阅1: \($0)") })
             
            //相当于把事件消息推迟了两秒
            delay(3) {
                _ = interval.connect()
            }
             
            //第二个订阅者（延迟5秒开始订阅）
            delay(10) {
                _ = interval
                    .subscribe(onNext: { print("订阅2: \($0)") })
            }
    }
    
    
    static public func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    
    /**
     
     3，replay
     （1）基本介绍
     replay 同上面的 publish 方法相同之处在于：会将将一个正常的序列转换成一个可连接的序列。同时该序列不会立刻发送事件，只有在调用 connect 之后才会开始。
     replay 与 publish 不同在于：新的订阅者还能接收到订阅之前的事件消息（数量由设置的 bufferSize 决定）。

     */
    
    static func __replay(){
        
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .replay(5)
                 
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
         
        //相当于把事件消息推迟了两秒
        delay(2) {
            _ = interval.connect()
        }
         
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
    }
    
    
    /**
     
     4，multicast
     （1）基本介绍
     multicast 方法同样是将一个正常的序列转换成一个可连接的序列。
     同时 multicast 方法还可以传入一个 Subject，每当序列发送事件时都会触发这个 Subject 的发送。
     
     */
    
    /**
     
     5，refCount
     （1）基本介绍
     refCount 操作符可以将可被连接的 Observable 转换为普通 Observable
     即该操作符可以自动连接和断开可连接的 Observable。当第一个观察者对可连接的 Observable 订阅时，那么底层的 Observable 将被自动连接。当最后一个观察者离开时，那么底层的 Observable 将被自动断开连接。
     
     */
    
    
    
}
