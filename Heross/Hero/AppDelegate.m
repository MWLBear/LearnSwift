
#import "AppDelegate.h"
#import "ViewController.h"
#import "UIDevice+TFDevice.h"


UIInterfaceOrientationMask static orientation = UIInterfaceOrientationMaskPortrait;
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

    return  orientation;

}

+(void)setOrientation:(NSString*)str{
    
    if ([str isEqual:@"V"]) {
        orientation = UIInterfaceOrientationMaskPortrait;
        [UIDevice switchNewOrientation:UIInterfaceOrientationPortrait];
    }else{
        orientation = UIInterfaceOrientationMaskLandscapeLeft;
        [UIDevice switchNewOrientation:UIInterfaceOrientationLandscapeLeft];


    }
}

@end
