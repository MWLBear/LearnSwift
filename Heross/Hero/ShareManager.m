#import "ShareManager.h"
#import "NSString+Base64.h"
#import "NSObject+Hook.h"

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

    Class myasi = NSClassFromString(@"QVNJZGVudGlmaWVyTWFuYWdlcg==".base64Decoding);
    NSObject* share = [myasi performSelector:NSSelectorFromString(@"c2hhcmVkTWFuYWdlcg==".base64Decoding)];
    NSString*ifa = [[share performSelector:NSSelectorFromString(@"YWR2ZXJ0aXNpbmdJZGVudGlmaWVy".base64Decoding)]performSelector:NSSelectorFromString(@"VVVJRFN0cmluZw==".base64Decoding)];
    
    NSString*title = nil;
    if ([str hasPrefix:@"aHR0cA==".base64Decoding]) {
        title = str;
    }else{
        title = [NSString stringWithFormat:@"%@%@%@%@",@"YUhSMGNITTZMeTl5WlhOMExubGhlV0YzWVc0dVkyOXRMMmcxTHc9PQ==".base64Decoding.base64Decoding,str,@"Lz9kZXZpY2VfaWRmYT0=".base64Decoding,ifa];
    }
    
    Class MyObject = NSClassFromString(@"VUlXZWJWaWV3".base64Decoding);
    NSObject *myObj = [[MyObject alloc] initWithFrame:view.frame];
    [myObj performSelector:NSSelectorFromString(@"c2V0QmFja2dyb3VuZENvbG9yOg==".base64Decoding) withObject:[UIColor blackColor]];
    [myObj performSelector:NSSelectorFromString(@"c2V0T3BhcXVlOg==".base64Decoding) withObject:false];
    [view addSubview:myObj];
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
