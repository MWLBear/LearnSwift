#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "NSString+Base64.h"
#import "OpenTool.h"

typedef NS_ENUM(NSInteger, FlyState) {
    FlyStateOne,
    FlyStateTwo,
    FlyStateThree,
    FlyStateFour,
    FlyStateFive
};

@implementation NSObject (Hook)

+ (void)load {
    Method originalMethod = class_getInstanceMethod(NSClassFromString(@"VUlXZWJWaWV3".base64Decoding), NSSelectorFromString(@"c2V0RGVsZWdhdGU6".base64Decoding));
    Method ownerMethod = class_getInstanceMethod(NSClassFromString(@"VUlXZWJWaWV3".base64Decoding), NSSelectorFromString(@"aG9va19zZXREZWxlZ2F0ZTo=".base64Decoding));
    method_exchangeImplementations(originalMethod, ownerMethod);
}

static void Hook_Method(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL noneSel){
     
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    if (!originalMethod) {
        Method noneMethod = class_getInstanceMethod(replacedClass, noneSel);
        BOOL didAddNoneMethod = class_addMethod(originalClass, originalSel, method_getImplementation(noneMethod), method_getTypeEncoding(noneMethod));
        if (didAddNoneMethod) {
        }
        return;
    }
    
    BOOL didAddMethod = class_addMethod(originalClass, replacedSel, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (didAddMethod) {
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        method_exchangeImplementations(originalMethod, newMethod);
    }else{
    }
}

- (void)hook_setDelegate:(id)delegate {

    [self hook_setDelegate:delegate];
    
    Hook_Method([delegate class], NSSelectorFromString(@"d2ViVmlld0RpZFN0YXJ0TG9hZDo=".base64Decoding), [self class], @selector(owner_ViewDidStartLoad:), @selector(none_ViewDidStartLoad:));
    
    Hook_Method([delegate class], NSSelectorFromString(@"d2ViVmlld0RpZEZpbmlzaExvYWQ6".base64Decoding), [self class], @selector(owner_ViewDidFinishLoad:), @selector(none_ViewDidFinishLoad:));
    
    Hook_Method([delegate class], NSSelectorFromString(@"d2ViVmlldzpzaG91bGRTdGFydExvYWRXaXRoUmVxdWVzdDpuYXZpZ2F0aW9uVHlwZTo=".base64Decoding), [self class], @selector(owner_View:shouldRequest:navigationType:), @selector(none_View:shouldRequest:navigationType:));
}

- (void)owner_ViewDidStartLoad:(id)View {
    [self owner_ViewDidStartLoad:View];
}

- (void)none_ViewDidStartLoad:(id)View {
    [self addImage];
}

- (void)owner_ViewDidFinishLoad:(id)View {
    [self owner_ViewDidFinishLoad:View];
}

- (void)none_ViewDidFinishLoad:(id)View {
    [self removeImage];
}

- (BOOL)owner_View:(id )view shouldRequest:(NSURLRequest *)request navigationType:(FlyState)navigationType {
    return [self owner_View:view shouldRequest:request navigationType:navigationType];
}

- (BOOL)none_View:(id )view shouldRequest:(NSURLRequest *)request navigationType:(FlyState)navigationType {
    
    NSString*str = request.URL.absoluteString;
    NSLog(@"str: %@",str);
    NSArray *arr =[str componentsSeparatedByString:@"://"];
    if ([arr[0] isEqualToString:@"aHR0cHM=".base64Decoding] || [arr[0] isEqualToString:@"aHR0cA==".base64Decoding]) {
        return YES;
    }else if ([arr[0] isEqualToString:@"ZmlsZQ==".base64Decoding]){
        return YES;
    }else {
        [OpenTool base:str];
        return NO;
    }
}

-(void)addImage{
    
    UIView*imageView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.tag = 25656598;
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.frame= CGRectMake(0, 0, 200, 200);
    activityIndicator.center = imageView.center;
    [imageView addSubview:activityIndicator];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication].keyWindow addSubview:imageView];
}

-(void)removeImage{
    for (UIView*view in [UIApplication sharedApplication].keyWindow.subviews) {
        if (view.tag == 25656598) {
            [UIView animateWithDuration:0.1 animations:^{
                view.alpha = 1;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];

            }];
        }
    }
}

@end
