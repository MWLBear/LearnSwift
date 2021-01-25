//
//  理解.swift
//  Kuchi
//
//  Created by admin on 2021/1/25.
//  Copyright © 2021 Omnijar. All rights reserved.
//

import Foundation
/**
 
 
 Use @State for simple properties that belong to a single view. They should usually be marked private.
 Use @ObservedObject for complex properties that might belong to several views. Any time you’re using a reference type you should be using @ObservedObject for it.
 Use @EnvironmentObject for properties that were created elsewhere in the app, such as shared data.

 
 
 
 总结差异:
 
 使用@State了属于一个单一的视图简单的属性。他们通常应该被标记private。
 使用@ObservedObject那些可能属于多个视图的复杂性。每当使用引用类型时，都应该使用@ObservedObject它。
 使用@EnvironmentObject针对在该应用别处创建属性，例如共享数据。
 
 
 */
