
#import "HeroGameServer.h"
#import "GCDWebServer.h"
#import "GCDWebServerResponse.h"
#import "GCDWebServerDataResponse.h"
#define port 12324

@interface HeroGameServer()
@property(nonatomic,strong)GCDWebServer *webServer;

@end

@implementation HeroGameServer
+ (instancetype)ShareGCDServer{
    static HeroGameServer *_sharedSingleton = nil;
       static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           _sharedSingleton = [[self alloc]init];
       });
       return _sharedSingleton;
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


@end
