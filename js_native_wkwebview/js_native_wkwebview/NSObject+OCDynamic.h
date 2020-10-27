//
//  NSObject+OCDynamic.h
//  js_native_wkwebview
//
//  Created by admin on 2020/10/14.
//  Copyright © 2020 apple. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (OCDynamic)
+(void)dy_hookSelector:(SEL)selector withBlock:(void (^)(id self ,NSInvocation*originalInvocation))block;

@end

NS_ASSUME_NONNULL_END
