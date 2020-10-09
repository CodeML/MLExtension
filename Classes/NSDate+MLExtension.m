//
//  NSDate+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "NSDate+MLExtension.h"

@implementation NSDate (MLExtension)

- (NSDate *)lastMonth {
    NSDateComponents *date = self.components;
    date.month -= 1;
    return date.toDate;
}

- (NSDate *)nextMonth {
    NSDateComponents *date = self.components;
    date.month += 1;
    return date.toDate;
}

+ (NSString *)toNow:(NSTimeInterval)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return date.toString;
}

// 获取当月的天数
- (NSInteger)getNumberOfDaysInMonth {
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit: NSCalendarUnitMonth forDate:self];
    return range.length;
}

- (BOOL)isThisMonth {
    NSDateComponents *now = NSDate.date.components;
    NSDateComponents *date = self.components;
    return date.year == now.year && date.month == now.month;
}

- (BOOL)isToday {
    NSDateComponents *now = NSDate.date.components;
    NSDateComponents *date = self.components;
    return date.year == now.year && date.month == now.month && date.day == now.day;
}

- (NSDateComponents *)components {

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateComponents *com = [[NSDateComponents alloc] init];

    NSInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    com = [calendar components:flags fromDate:self];

    return com;
}

- (NSInteger)differenceDaysByNow {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return -[gregorian components:NSCalendarUnitDay fromDate:self toDate:NSDate.date  options:0].day;
}

- (NSString *)toString {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    return [dateFormatter stringFromDate:self];
}

- (NSString *)toStringWithFormat:(NSString *)format {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:format];

    return [dateFormatter stringFromDate:self];
}

- (NSUInteger)totalDays {
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

- (NSUInteger)remainingDays {
    return [self totalDays] - self.components.day;
}

- (NSInteger)firstDayWeek {
    NSDateComponents *comps = self.components;
    comps.day = 1;
    NSDate *firstDay = comps.toDate;
    return firstDay.components.weekday;
}

- (BOOL)isSame:(NSDate *)date {
    NSDateComponents *comp1 = self.components;
    NSDateComponents *comp2 = date.components;
    return comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day;
}

- (NSDate *)yesterday {
    return [self dateByAddingTimeInterval:-24 * 60 * 60];
}

- (NSDate *)tomorrow {
    return [self dateByAddingTimeInterval:24 * 60 * 60];
}
@end
