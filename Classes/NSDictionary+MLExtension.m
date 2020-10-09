//
//  NSDictionary+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "NSDictionary+KMExtension.h"
#import <MJExtension/MJExtension.h>

@implementation NSDictionary (KMExtension)
- (MLBaseModel *)toModel:(NSString *)modelName {
    return [NSClassFromString(modelName) mj_objectWithKeyValues:self];
}

- (MLBaseCellModel *)toModel {
    return [NSClassFromString(@"MLBaseCellModel") mj_objectWithKeyValues:self];
}

- (NSString *)toString {
    NSMutableString *str = [@"{" mutableCopy];
    NSArray *keys = self.allKeys;
    for (NSString *key in keys) {
        [str appendString:[NSString stringWithFormat:@"\"%@\" : \"%@\"", key, [self objectForKey:key]]];
        if (![key isEqualToString:keys.lastObject]) {
            [str appendString:@","];
        }else{
            [str appendString:@"}"];
        }
    }
    return str;
}

- (NSString *)toRequest {
    NSMutableString *str = [@"?" mutableCopy];
    NSArray *keys = self.allKeys;
    for (NSString *key in keys) {
        [str appendString:[NSString stringWithFormat:@"%@=%@", key, [self objectForKey:key]]];
        if (![key isEqualToString:keys.lastObject]) {
            [str appendString:@"&"];
        }
    }
    return str;
}
@end
