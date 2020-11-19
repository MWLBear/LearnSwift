//

#import "NSString+Base64.h"

@implementation NSString (Base64)

-(NSString *)base64Encoding {
   NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
   
   return [data base64EncodedStringWithOptions:0];;
}
- (NSString *)base64Decoding {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return decodedString;
}
@end
