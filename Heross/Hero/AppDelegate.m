
#import "AppDelegate.h"
#import "ViewController.h"
#import "UIDevice+TFDevice.h"

static void blockCleanUp(__strong void(^*block)(void)) {
    (*block)();
}
#define onExit\
    __strong void(^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^

UIInterfaceOrientationMask static orientation = UIInterfaceOrientationMaskPortrait;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   
    
    NSString*name =  [[NSTimeZone localTimeZone] name];
    NSLog(@"name = %@",name);
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    [_window setRootViewController:[[ViewController alloc]init]];
    [_window makeKeyAndVisible];

    onExit {
        NSLog(@"yo-------");
    };
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
