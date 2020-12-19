
#import "UIDevice+TFDevice.h"

@implementation UIDevice (TFDevice)
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:interfaceOrientation];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    
}
@end
