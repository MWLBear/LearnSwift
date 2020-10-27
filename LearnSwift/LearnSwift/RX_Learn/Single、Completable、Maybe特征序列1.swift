//
//  Single、Completable、Maybe特征序列1.swift
//  LearnSwift
//
//  Created by admin on 2020/9/7.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum DataError: Error {
    case cantParseJSON
}
enum CacheError: Error {
    case failedCaching
}

class Single_Completable_Maybe____1: NSObject {

    /**
     
     Observable 是能够用于任何上下文环境的通用序列。
     而 Traits 可以帮助我们更准确的描述序列。同时它们还为我们提供上下文含义、语法糖，让我们能够用更加优雅的方式书写代码。
     
     */
    /**
     
     1，基本介绍
     Single 是 Observable 的另外一个版本。但它不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件。
     发出一个元素，或一个 error 事件
     不会共享状态变化
     
     */
    
    static func getPlaylist1(_ channel:String)->Single<[String:Any]>{
        
        return Single<[String:Any]>.create { single in
            
            let url = "https://douban.fm/j/mine/playlist?"
            + "type=n&channel=\(channel)&from=mainsite"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, resposne, error) in
                if let error = error{
                    single(.error(error))
                    return
                }
                
                guard let data = data,let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves), let  result = json as? [String :Any] else{
                    
                    single(.error(DataError.cantParseJSON))
                    return
                }
                
                single(.success(result))
            }
            task.resume()
            
            return Disposables.create{task.cancel()}
        }
    
    }
    
    
    /**
     
     2，
     Completable 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件。
     不会发出任何元素
     只会发出一个 completed 事件或者一个 error 事件
     不会共享状态变化
     
     Completable 和 Observable<Void> 有点类似。适用于那些只关心任务是否完成，而不需要在意任务返回值的情况。比如：在程序退出时将一些数据缓存到本地文件，供下次启动时加载。像这种情况我们只关心缓存是否成功。
     
     */
  
    static func cacheLocally() -> Completable {
        return Completable.create { completable in
            
            let success = (arc4random() % 2 == 0)
            
            guard success else{
                completable(.error(CacheError.failedCaching))
                return Disposables.create()
            }
            
            completable(.completed)
            
            return Disposables.create()
        }
        
    }
    
    /**
     三、Maybe
     1，基本介绍
     Maybe 同样是 Observable 的另外一个版本。它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。
     发出一个元素、或者一个 completed 事件、或者一个 error 事件
     不会共享状态变化
     
     
     2，应用场景
     Maybe 适合那种可能需要发出一个元素，又可能不需要发出的情况。
     
     5，asMaybe()
     （1）我们可以通过调用 Observable 序列的 .asMaybe() 方法，将它转换为 Maybe。
     
     */
    
   
    static func generateString()->Maybe<String>{
        return Maybe.create { maybe -> Disposable in
            
            maybe(.success("apple.com"))
            maybe(.completed)

            return Disposables.create()
        }
    }
    
}
