//
//  Driver特征序列2.swift
//  LearnSwift
//
//  Created by admin on 2020/9/7.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class Driver____2: NSObject {

    /**
     
     1，基本介绍
     （1）Driver 可以说是最复杂的 trait，它的目标是提供一种简便的方式在 UI 层编写响应式代码。
     （2）如果我们的序列满足如下特征，就可以使用它：
     不会产生 error 事件
     一定在主线程监听（MainScheduler）
     共享状态变化（shareReplayLatestWhileConnected
     
     
     2，为什么要使用 Driver?
     （1）Driver 最常使用的场景应该就是需要用序列来驱动应用程序的情况了，比如：
     通过 CoreData 模型驱动 UI
     使用一个 UI 元素值（绑定）来驱动另一个 UI 元素值
     （2）与普通的操作系统驱动程序一样，如果出现序列错误，应用程序将停止响应用户输入。
     （3）在主线程上观察到这些元素也是极其重要的，因为 UI 元素和应用程序逻辑通常不是线程安全的。
     （4）此外，使用构建 Driver 的可观察的序列，它是共享状态变化。
     
     
     
     */
    
    
}
