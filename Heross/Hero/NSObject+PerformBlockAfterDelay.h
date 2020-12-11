//
//  NSObject+PerformBlockAfterDelay.h
//  Hero
//
//  Created by admin on 2020/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PerformBlockAfterDelay)
- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay;
@end

NS_ASSUME_NONNULL_END
