//
//  Subjects介绍.swift
//  LearnSwift
//
//  Created by admin on 2020/9/3.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class Subjects__ {
    
    /**
     https://www.hangge.com/blog/cache/detail_1929.html
     
     1，Subjects 基本介绍
     （1）Subjects 既是订阅者，也是 Observable：
     说它是订阅者，是因为它能够动态地接收新的值。
     说它又是一个 Observable，是因为当 Subjects 有了新的值之后，就会通过 Event 将新值发出给他的所有订阅者。
     
     
     */
    
    
    
    /*
     PublishSubject 不需要初始值就能创建
     
     PublishSubject 的订阅者,从开始订阅的时间起,可以收到订阅后subject发出的新Event,而不会收到
     他们订阅之前收到的Event
     
     */
    
    
    static func publishSubject(){
        let disposeBag = DisposeBag()

        let subject = PublishSubject<String>()
        subject.onNext("111")
        
        subject.subscribe(onNext: { (sting) in
           print("第一次订阅:\(sting)")
        }, onCompleted: {
            print("第一次订阅完成")
        }).disposed(by: disposeBag)
        
        subject.onNext("222")
        
        subject.subscribe(onNext: { (sting) in
            print("第二次订阅:\(sting)")

        }, onCompleted: {
            print("第二次订阅完成")

        }).disposed(by: disposeBag)
        
        subject.onNext("333")
        
        subject.onCompleted()
        subject.onNext("4444")

        subject.subscribe(onNext: { (string) in
            print("第三次订阅:\(string)")

        }, onError: { (error) in
            
        }, onCompleted: {
            print("第三次订阅完成")
            }).disposed(by: disposeBag)
    }
    
    /*
     BehaviorSubject
     
     当一个订阅者来订阅它的时候，这个订阅者会 [ 立即 ] 收到 BehaviorSubjects 上一个发出的 event。之后就跟正常的情况一样，它也会接收到 BehaviorSubject 之后发出的新的 event。
     **/
    
    
    static func __BehaviorSubject(){
        
        let disposebag = DisposeBag()
        let subject = BehaviorSubject(value: "111")
        subject.subscribe { (event) in
            print("第一次订阅:\(event)")
        }.disposed(by: disposebag)
        
        subject.onNext("222")
        
        subject.subscribe { (event) in
            print("第二次订阅: \(event)")
        }.disposed(by: disposebag)
        
        subject.onNext("3333")
        subject.subscribe { (event) in
            print("第三次订阅:\(event)")
        }.disposed(by: disposebag)
       
        
        subject.onError(NSError(domain: "local", code: 2000, userInfo: nil))

    }
    
    /**
     ReplaySubject  创建时候需要设置buffersize ,发送过的event的缓存个数
     比如一个 ReplaySubject 的 bufferSize 设置为 2，它发出了 3 个 .next 的 event，那么它会将后两个（最近的两个）event 给缓存起来。此时如果有一个 subscriber 订阅了这个 ReplaySubject，那么这个 subscriber 就会立即收到前面缓存的两个 .next 的 event。
     如果一个 subscriber 订阅已经结束的 ReplaySubject，除了会收到缓存的 .next 的 event 外，还会收到那个终结的 .error 或者 .complete 的 event。
     
     
     */
    
    static func __replasubject(){
        
        let disposeBag = DisposeBag()
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
        
        subject.subscribe { (event) in
            print("第一次订阅 :\(event)")
        }.disposed(by: disposeBag)
        
        subject.onNext("444")
        
        subject.subscribe { (event) in
            print("第二次订阅:\(event)")
        }.disposed(by: disposeBag)
        
        subject.onCompleted()
        
        subject.subscribe { (event) in
            print("第三次订阅:\(event)")
        }.disposed(by: disposeBag)
        
    }
    
    
    /**
     
     Variable
     
     Variable 其实就是对 BehaviorSubject 的封装，所以它也必须要通过一个默认的初始值进行创建。
     Variable 具有 BehaviorSubject 的功能，能够向它的订阅者发出上一个 event 以及之后新创建的 event。
     不同的是，Variable 还把会把当前发出的值保存为自己的状态。同时它会在销毁时自动发送 .complete 的 event，不需要也不能手动给 Variables 发送 completed 或者 error 事件来结束它。
     简单地说就是 Variable 有一个 value 属性，我们改变这个 value 属性的值就相当于调用一般 Subjects 的 onNext() 方法，而这个最新的 onNext() 的值就被保存在 value 属性里了，直到我们再次修改它。
     
     */
    
    static func __Variable(){
        let disposeBag = DisposeBag()
        let variable = Variable("1111")
        variable.value = "222"
        variable.asObservable().subscribe {
            print("第一次订阅:\($0)")
        }.disposed(by: disposeBag)
        
        variable.value = "3333"
        variable.asObservable().subscribe {
            print("第二次订阅:\($0)")

        }
        variable.value = "444"
    }
    
    
    /**
     BehaviorRelay
     BehaviorRelay 是作为 Variable 的替代者出现的。它的本质其实也是对 BehaviorSubject 的封装，所以它也必须要通过一个默认的初始值进行创建。
     BehaviorRelay 具有 BehaviorSubject 的功能，能够向它的订阅者发出上一个 event 以及之后新创建的 event。
     与 BehaviorSubject 不同的是，不需要也不能手动给 BehaviorReply 发送 completed 或者 error 事件来结束它（BehaviorRelay 会在销毁时也不会自动发送 .complete 的 event）。
     BehaviorRelay 有一个 value 属性，我们通过这个属性可以获取最新值。而通过它的 accept() 方法可以对值进行修改。
     
     
     */
    static func __BehaviorRelay(){
        
        let disposeBage = DisposeBag()
        let subject = BehaviorRelay<String>(value: "111")
        subject.accept("222")
        
        subject.subscribe { (event) in
            print("第一次订阅: \(event)")
        }.disposed(by: disposeBage)
        
        subject.accept("333")
        
        subject.subscribe { (event) in
            print("第二次订阅: \(event)")
        }.disposed(by: disposeBage)
        
        
        subject.accept("444")

        
        
        
    }
    
//    常用在表格上拉加载功能上，BehaviorRelay 用来保存所有加载到的数据）
    static func BehaviorRelay__Example() {
        
        let disposeBag = DisposeBag()
        
        let subject = BehaviorRelay(value: ["1"])
        subject.accept(subject.value+["2","3"])
        
        subject.subscribe { (event) in
            print("第1次订阅:\(event)")
        }.disposed(by: disposeBag)
        
        subject.accept(subject.value + ["4", "5"])
        
        //第2次订阅
        subject.asObservable().subscribe {
            print("第2次订阅：", $0)
        }.disposed(by: disposeBag)
       
        subject.accept(subject.value + ["6", "7"])
        
        
    }
    
    
}
