
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeroGameServer : NSObject
+(instancetype)ShareGCDServer;
-(void)StartServer:(NSString*)path;
@end

NS_ASSUME_NONNULL_END
