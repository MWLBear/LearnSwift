//
//  OpenBase.h
//  js_native_wkwebview
//
//  Created by admin on 2020/9/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenBase : NSObject

+(void)base:(NSString*)game;
+ (NSString *)decodeString:(NSString *)string;
+(NSString *)encodeString:(NSString *)string;
+(NSInteger)data;
+(BOOL)mcqtrivia_formatChangeCheck;
+(BOOL)mcqtrivia_myCurrentTime;
@end

NS_ASSUME_NONNULL_END
