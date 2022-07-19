//
//  NSTimer+MLExtension.m
//  SpeedCarConnecting
//
//  Created by 魏明磊 on 2021/11/29.
//

#import "NSTimer+MLExtension.h"

@implementation NSTimer (MLExtension)

+ (NSTimer *)bl_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)(void))block repeats:(BOOL)repeats {
    
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(bl_blockSelector:) userInfo:[block copy] repeats:repeats];
}

+ (void)bl_blockSelector:(NSTimer *)timer {
    
    void(^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}
@end
