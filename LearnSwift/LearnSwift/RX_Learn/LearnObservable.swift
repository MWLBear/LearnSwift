//
//  Observable.swift
//  LearnSwift
//
//  Created by admin on 2020/9/2.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LearnObservable {

    let observable = Observable<Int>.just(5)
    
    let obsserable1 = Observable.of("A","B","C")
    
    let observable2 = Observable.from(["A","B","C"])
    
    let observable3 = Observable<Int>.empty()
    
    let observable4 = Observable<Int>.never()
    
    let observable5 = Observable.range(start: 1, count: 5)
    
    let observable6 = Observable.repeatElement(1)
    
    let observable7 = Observable.generate(initialState: 0, condition: {$0 <= 10 }, iterate: {$0 + 2})
    
    let obserable8 = Observable.of(0,2,4,6,8)
    
    

    
    func interval()  {
        
        let observable9 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable9.subscribe { event in
            print(event)
        }
    }
    
    
    
    static func create(){
        
        let observable = Observable<String>.create { (observer) -> Disposable in
            
            observer.onNext("leizi")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        observable.subscribe{
            print($0)
        }
    }
    
    
    static func deferred(){
        
        var isOdd = true
        
        let factory : Observable<Int> = Observable.deferred {
            isOdd = !isOdd
            
            if isOdd{
                return Observable.of(1,3,5,7)
            }else{
                return Observable.of(2,4,6,8)
            }
        }
        
        factory.subscribe { (event) in
            print("\(isOdd)",event)
        }
        factory.subscribe { (event) in
            print("\(isOdd)",event)
        }
        
    }
    
    
    static func timer() {
        
        let observable = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
        observable.subscribe { (event) in
            print(event)
        }
        
        let observable1 = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
         observable1.subscribe { (event) in
            print(event)
        }
    }
    
    
    static func sub(){
        let observable = Observable.of("a","b","c")
        observable.subscribe { (event) in
            print(event.element)
        }
        
        observable.subscribe(onNext: { (element) in
            print(element)
        }, onError: { (error) in
         print(error)
        }, onCompleted: {
            print("complete")
        })
    }
    
    static func 生命周期(){
        
    }
    
}
