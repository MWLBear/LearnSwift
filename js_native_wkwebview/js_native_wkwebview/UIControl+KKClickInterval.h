//
//  UIControl+KKClickInterval.h
//  js_native_wkwebview
//
//  Created by admin on 2020/12/1.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 全局避免 UIButton 频繁点击
 
 
 
 */
@interface UIControl (KKClickInterval)

/// 点击事件响应的时间间隔，不设置或者大于 0 时为默认时间间隔
@property (nonatomic, assign) NSTimeInterval clickInterval;
/// 是否忽略响应的时间间隔
@property (nonatomic, assign) BOOL ignoreClickInterval;
+ (void)kk_exchangeClickMethod;

@end

NS_ASSUME_NONNULL_END
/**
 cls:获得哪个类中的方法
 SEL name:获得方法的对象
*/

//class_getInstanceMethod(Class  _Nullable __unsafe_unretained cls , SEL  _Nonnull name)

/**
 object:关联的源对象
 key:关联的 key
*/

//objc_getAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>);

/**
 object:关联的源对象
 key:关联的 key
 value:关联对象的值，可以通过将此值置成 nil 来清除关联
 policy:关联的策略
*/
//objc_setAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>, <#id  _Nullable value#>, <#objc_AssociationPolicy policy#>)
