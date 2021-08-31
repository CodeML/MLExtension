//
//  NSDateComponents+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "NSDateComponents+MLExtension.h"
#import "NSDate+MLExtension.h"

@implementation NSDateComponents (MLExtension)
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
