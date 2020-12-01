
#import "Net.h"
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "NSString+Base64.h"
#import "NSObject+Hook.h"


typedef void(^myBlock)(void);

@interface Net()
@property(nonatomic,strong)NSTimer*timer;
@property (nonatomic, copy) myBlock wBlcok;
@property(nonatomic,strong)UIAlertController*alertVc;
@end

@implementation Net
+(instancetype)sharedInstance{
    static dispatch_once_t once ;
    static Net *_instace = nil;
    dispatch_once(&once, ^{
        _instace = [[self  alloc] init];
    });
    return _instace;
}


-(void)startTimer: (void(^)(void))finish{
    
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(internetstatus) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];

    self.wBlcok = finish;
}

-(void)netsucess{
    [self fireTier];
    
    [[[UIApplication sharedApplication]keyWindow].rootViewController dismissViewControllerAnimated:NO completion:nil];
    
    if (self.wBlcok) {
        self.wBlcok();
    }
}

-(void)fireTier{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)showNotice{
   
    UIAlertController*altvc = [UIAlertController alertControllerWithTitle:@"" message:@"5b2T5YmN572R57uc54q25oCB5LiN5L2zLOivt+mHjeivleaIluiAheWJjeW+gOajgOafpee9kee7nOiuvue9rg==".base64Decoding preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action = [UIAlertAction actionWithTitle:@"6YeN6K+V".base64Decoding style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [NSObject show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [NSObject diss];
            [self internetstatus];
        });
        
    }];
    UIAlertAction*action1 = [UIAlertAction actionWithTitle:@"5YmN5b6A5qOA5p+l".base64Decoding style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:0 completionHandler:nil];
        [self internetstatus];
    }];
    [altvc addAction:action];
    [altvc addAction:action1];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:altvc animated:NO completion:nil];
}


-(void)internetstatus {

    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    switch (internetStatus) {
        case ReachableViaWiFi:
            [self netsucess];
            break;
        case ReachableViaWWAN:
            [self netsucess];
            break;

        case NotReachable:
            [self showNotice];
        default:
            break;
    }
}

@end
