//
//  NSTimer+MLExtension.h
//  SpeedCarConnecting
//
//  Created by 魏明磊 on 2021/11/29.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (MLExtension)
+ (NSTimer *)bl_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)(void))block repeats:(BOOL)repeats;
@end

NS_ASSUME_NONNULL_END
