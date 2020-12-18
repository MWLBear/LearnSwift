
#import "AppDelegate.h"
#import "ViewController.h"

UIInterfaceOrientationMask static orientation = UIInterfaceOrientationMaskLandscape;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_window setRootViewController:[[ViewController alloc]init]];
    [_window makeKeyAndVisible];

    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return orientation;
}

+(void)setOrientation:(NSString*)str{
    if ([str isEqual:@"V"]) {
        orientation = UIInterfaceOrientationMaskPortrait;
        NSNumber*o = [NSNumber numberWithInteger:orientation];
        [[UIDevice currentDevice]setValue:o forKey:@"orientation"];
        
    }else{
        NSLog(@"gadgadgadga");
        orientation = UIInterfaceOrientationMaskLandscapeLeft;
        NSNumber*o = [NSNumber numberWithInteger:orientation];
        [[UIDevice currentDevice]setValue:o forKey:@"orientation"];
    }
}
@end
