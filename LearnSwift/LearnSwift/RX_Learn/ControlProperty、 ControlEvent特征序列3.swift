//
//  ControlProperty、 ControlEvent特征序列3.swift
//  LearnSwift
//
//  Created by admin on 2020/9/7.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ControlProperty__ControlEvent____3: NSObject {

    /**
     
     ControlProperty
     1，基本介绍
     （1）ControlProperty 是专门用来描述 UI 控件属性，拥有该类型的属性都是被观察者（Observable）。
     （2）ControlProperty 具有以下特征：
     不会产生 error 事件
     一定在 MainScheduler 订阅（主线程订阅）
     一定在 MainScheduler 监听（主线程监听）
     共享状态变化
     
     
     
     六 、ControlEvent
     1，基本介绍
     （1）ControlEvent 是专门用于描述 UI 所产生的事件，拥有该类型的属性都是被观察者（Observable）。
     （2）ControlEvent 和 ControlProperty 一样，都具有以下特征：
     不会产生 error 事件
     一定在 MainScheduler 订阅（主线程订阅）
     一定在 MainScheduler 监听（主线程监听）
     共享状态变化
     
     
     
     */
}
