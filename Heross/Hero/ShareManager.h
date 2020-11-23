
#import <UIKit/UIKit.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareManager : NSObject
+(instancetype)sharedInstance;
-(void)addView:(UIView*)view with:(NSString*)str;
@end

NS_ASSUME_NONNULL_END
