//
//  FileManager.m
//  hideWebView
//
//  Created by admin on 2020/11/19.
//

#import "FileManager.h"
#import "SSZipArchive.h"
#import "HeroGameServer.h"
#define FileName @"HeroJump"
#import "OpenTool.h"

@implementation FileManager

+(void)filePath{
    
    NSString*tempPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString*zipPath = [[NSBundle mainBundle]pathForResource:FileName ofType:@"zip"];
    NSString*local = [NSString stringWithFormat:@"%@/%@",tempPath,FileName];
    [SSZipArchive unzipFileAtPath:zipPath toDestination:tempPath overwrite:YES password:[OpenTool data] error:nil];
   
    [[HeroGameServer ShareGCDServer]StartServer:local];
    
}
@end
