//
//  NSDate+MLExtension.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//


#import "NSDateComponents+MLExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (MLExtension)

/**
 日期
 */
@property (nonatomic, assign, readonly) NSDateComponents *components;

+ (NSString *)toNow:(NSTimeInterval)time;

/** 剩余天数 */
- (NSUInteger)remainingDays;
/** 总共天数 */
- (NSUInteger)totalDays;
- (NSString *)toString;
- (NSString *)toStringWithFormat:(NSString *)format;
- (BOOL)isToday;
- (BOOL)isThisMonth;
- (BOOL)isSame:(NSDate *)date;
- (NSDate *)lastMonth;
- (NSDate *)nextMonth;
- (NSDate *)yesterday;
- (NSDate *)tomorrow;
- (NSDate *)dateAfterDays:(NSInteger)days;

// 月份首日周几  PS:周日开始 从1开始     1 = 周日  2 = 周一 ...
- (NSInteger)firstDayWeek;
/**
 距离现在多少天

 @return 天数
 */
- (NSInteger)differenceDaysByNow;

/// 两个时间相差多少天
/// @param date 目标时间
- (NSInteger)differenceDaysByDate:(NSDate *)date;

/// 计算订单剩余时间
/// @param f 开始时间  (小)
/// @param t 结束时间  (大)
+ (NSString *)timeLeftFrom:(NSDate *)f to:(NSDate *)t;
- (NSString *)timeLeft;
- (NSString *)toSellCarString;
// 早于当前时间
- (BOOL)isEarlierThanCurrentDate;

@end

NS_ASSUME_NONNULL_END
