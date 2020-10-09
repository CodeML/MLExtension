//
//  NSDateComponents+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "NSDateComponents+KMExtension.h"

@implementation NSDateComponents (KMExtension)
- (NSDate *)toDate {
    return [[NSCalendar currentCalendar] dateFromComponents:self];
}

- (NSString *)toString {
    return [self toStringWithFormat:@"yyyy-MM-dd"];
}

- (NSString *)toStringWithFormat:(NSString *)format {
    return [self.toDate toStringWithFormat:format];
}
@end
