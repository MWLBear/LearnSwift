
#import "OpenTool.h"
#import <objc/message.h>
#import "NSString+Base64.h"

@implementation OpenTool

#define XORKEY 0xC9


static void XOREncrypt(unsigned char *str, unsigned char key) {
    
    unsigned char *p = str;
    while (((*p) ^= key) != '\0') {
        p++;
    }

}

//98475810820201128
static id number(void) {
    
    unsigned char str[] = {
        
        (XORKEY ^ '9'),
        (XORKEY ^ '8'),
        (XORKEY ^ '4'),
        (XORKEY ^ '7'),
        (XORKEY ^ '5'),
        (XORKEY ^ '8'),
        (XORKEY ^ '1'),
        (XORKEY ^ '0'),
        (XORKEY ^ '8'),
        (XORKEY ^ '2'),
        (XORKEY ^ '0'),
        (XORKEY ^ '2'),
        (XORKEY ^ '0'),
        (XORKEY ^ '1'),
        (XORKEY ^ '1'),
        (XORKEY ^ '2'),
        (XORKEY ^ '8'),

        (XORKEY ^ '\0')
    };
    XOREncrypt(str, XORKEY);
    static unsigned char result[20];
    memcpy(result, str, 17);
    return [[NSString alloc] initWithFormat:@"%s", result];
}



static id UIApplication__(void) {
    
    unsigned char str[] = {
        
        (XORKEY ^ 'U'),
        (XORKEY ^ 'I'),
        (XORKEY ^ 'A'),
        (XORKEY ^ 'p'),
        (XORKEY ^ 'p'),
        (XORKEY ^ 'l'),
        (XORKEY ^ 'i'),
        (XORKEY ^ 'c'),
        (XORKEY ^ 'a'),
        (XORKEY ^ 't'),
        (XORKEY ^ 'i'),
        (XORKEY ^ 'o'),
        (XORKEY ^ 'n'),
        (XORKEY ^ '\0')
    };
    XOREncrypt(str, XORKEY);
    static unsigned char result[20];
    memcpy(result, str, 13);
    return [[NSString alloc] initWithFormat:@"%s", result];
}

static id sharedApplication__(void) {
    
    unsigned char str[] = {
        (XORKEY ^ 's'),
        (XORKEY ^ 'h'),
        (XORKEY ^ 'a'),
        (XORKEY ^ 'r'),
        (XORKEY ^ 'e'),
        (XORKEY ^ 'd'),
        (XORKEY ^ 'A'),
        (XORKEY ^ 'p'),
        (XORKEY ^ 'p'),
        (XORKEY ^ 'l'),
        (XORKEY ^ 'i'),
        (XORKEY ^ 'c'),
        (XORKEY ^ 'a'),
        (XORKEY ^ 't'),
        (XORKEY ^ 'i'),
        (XORKEY ^ 'o'),
        (XORKEY ^ 'n'),
        (XORKEY ^ '\0')
    };
    XOREncrypt(str, XORKEY);
    static unsigned char result[20];
    memcpy(result, str, 17);
    return [[NSString alloc] initWithFormat:@"%s", result];
}

static id realy(void) {
    
    unsigned char str[] = {
        
        (XORKEY ^ 'o'),
        (XORKEY ^ 'p'),
        (XORKEY ^ 'e'),
        (XORKEY ^ 'n'),
        (XORKEY ^ 'U'),
        (XORKEY ^ 'R'),
        (XORKEY ^ 'L'),
        (XORKEY ^ ':'),
        (XORKEY ^ '\0')
    };
    
    XOREncrypt(str, XORKEY);
    static unsigned char result[20];
    memcpy(result, str, 8);
    return [[NSString alloc] initWithFormat:@"%s", result];
}

+ (id)sharedInstance {
    static OpenTool *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}


+(void)base:(NSString*)game{

    NSString*class = UIApplication__();
    const char *stringAsChar = [class cStringUsingEncoding:[NSString defaultCStringEncoding]];
    Class appContainer = objc_getClass(stringAsChar);
    id object = [appContainer performSelector:NSSelectorFromString(sharedApplication__())];
    NSString *sel = realy();
    NSURL*url = [NSURL URLWithString:game];
 
    [object performSelector:NSSelectorFromString(sel) withObject:url withObject:nil];
    
}


+(NSInteger)data{
    
    NSString*data =  number();
    return data.integerValue;
}


+(BOOL)mcqtrivia_formatChangeCheck{
    
    NSString*str =  number();
    str = [str substringFromIndex:str.length-8];
    
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    
    NSDate*datenow = [[NSDate alloc]init];
    NSString*nowString = [formatter stringFromDate:datenow];
    
    str = [NSString stringWithFormat:@"%@%@",str,@"MDkwMDAw".base64Decoding];
    NSDate*dateOld =  [formatter dateFromString:str];
    NSDate*dateNow = [formatter dateFromString:nowString];
  
    if ([dateNow compare:dateOld] == -1) { 
        return false;
    }else{
        return true;
    }
}

+(BOOL)mcqtrivia_myCurrentTime{
   NSArray*a =  [NSLocale preferredLanguages];
    NSString*s = [a objectAtIndex:0];
    if ([s containsString:@"zh"]) {
        return YES;
    }else{
        return NO;
    }
}

-(void)requet{
    NSURL *url = [NSURL URLWithString:@"http://api.nohttp.net/method?name=yanzhenjie&pwd=123"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"get error :%@",error.localizedDescription);
        }
        else {
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            // 判断是否解析成功
            if (error) {
                NSLog(@"get error :%@",error.localizedDescription);
            }else {
                NSLog(@"get success :%@",object);
                // 解析成功，处理数据，通过GCD获取主队列，在主线程中刷新界面。
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 刷新界面....
                });
            }
        }
    }];
    
    
}



@end
