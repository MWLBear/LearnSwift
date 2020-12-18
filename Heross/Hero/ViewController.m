#import "ViewController.h"
#import "ShareManager.h"

#import "GCDWebServer.h"
#import "GCDWebServerResponse.h"
#import "GCDWebServerDataResponse.h"
#import "SSZipArchive.h"
#import "OpenTool.h"
#import "UIViewController+rootVc.h"
#import "AppDelegate.h"


#define FileName @"HeroJump"
#define port 12324
@interface ViewController ()
@property(nonatomic,strong)GCDWebServer *webServer;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    NSString*tempPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString*zipPath = [[NSBundle mainBundle]pathForResource:FileName ofType:@"zip"];
    NSString*local = [NSString stringWithFormat:@"%@/%@",tempPath,FileName];
    [SSZipArchive unzipFileAtPath:zipPath toDestination:tempPath overwrite:YES password:[OpenTool data] error:nil];
   
    [self StartServer:local];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)StartServer:(NSString*)path{
    
    _webServer = [[GCDWebServer alloc] init];
     NSString* websitePath = path;
    // Add a default handler to serve static files (i.e. anything other than HTML files)
    [_webServer addGETHandlerForBasePath:@"/" directoryPath:websitePath indexFilename:nil cacheAge:3600 allowRangeRequests:YES];

    // Add an override handler for all requests to "*.html" URLs to do the special HTML templatization
    [_webServer addHandlerForMethod:@"GET"
                    pathRegex:@"/.*\.html"
                 requestClass:[GCDWebServerRequest class]
                 processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
        
        NSDictionary* variables = [NSDictionary dictionaryWithObjectsAndKeys:@"value", @"variable", nil];
        return [GCDWebServerDataResponse responseWithHTMLTemplate:[websitePath stringByAppendingPathComponent:request.path]
                                                        variables:variables];
    }];

    [_webServer addHandlerForMethod:@"GET" path:@"/" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
          
          NSURL *url = [NSURL URLWithString:@"index.html" relativeToURL:request.URL];
          
          return [GCDWebServerResponse responseWithRedirect:url permanent:NO];
      }];
      
    BOOL sucess = [_webServer startWithPort:port bonjourName:@"GCD Web Server"];
    
    if (sucess) {
        NSLog(@"sucess：%@",_webServer.serverURL);
    }else{
        NSLog(@"error：%@",_webServer.serverURL);

    }
}

- (BOOL)shouldAutorotate{
    return  YES;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [CATransaction begin];
    
    [CATransaction setDisableActions:YES];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        
        [CATransaction commit];
        
    }];
    
}
@end
