//
//  NSDate+MLExtension.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//


#import "NSDateComponents+KMExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (KMExtension)

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
- (NSInteger)getNumberOfDaysInMonth;
- (NSDate *)lastMonth;
- (NSDate *)nextMonth;
- (NSDate *)yesterday;
- (NSDate *)tomorrow;

// 月份首日周几  PS:周日开始 从1开始     1 = 周日  2 = 周一 ...
- (NSInteger)firstDayWeek;
/**
 距离现在多少天

 @return 天数
 */
- (NSInteger)differenceDaysByNow;
@end

NS_ASSUME_NONNULL_END
