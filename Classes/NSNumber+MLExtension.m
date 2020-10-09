//
//  NSNumber+KMToString.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "NSNumber+KMToString.h"

@implementation NSNumber (KMToString)
- (NSString *)toString {
    return [NSString stringWithFormat:@"%@", self];
}
@end
