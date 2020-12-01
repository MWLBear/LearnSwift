#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Net : NSObject
+(instancetype)sharedInstance;
-(void)startTimer:(void(^)(void))finish;
@end

NS_ASSUME_NONNULL_END
