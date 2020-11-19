//
//  UIWindow+rootVc.m
//  js_native_wkwebview
//
//  Created by admin on 2020/11/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import "UIWindow+rootVc.h"
#import <objc/runtime.h>

@implementation UIWindow (rootVc)

+(void)load  {
    swizzleMethod([self class], @selector(setRootViewController:), @selector(swizzled_setRootViewController:));
}

-(void)swizzled_setRootViewController:(UIViewController*)viewController{
    
    NSLog(@"swizzled_setRootViewController");
    
    [self swizzled_setRootViewController:viewController];
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

@end
