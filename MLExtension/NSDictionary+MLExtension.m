//
//  NSDictionary+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "NSDictionary+MLExtension.h"
#import <MJExtension/MJExtension.h>
#import <YYKit/NSObject+YYModel.h>

@implementation NSDictionary (MLExtension)
- (MLBaseModel *)toModel:(NSString *)modelName {
    return [NSClassFromString(modelName) modelWithJSON:self];
}

- (MLBaseCellModel *)toModel {
    return (MLBaseCellModel *)[self toModel:@"MLBaseCellModel"];
}

- (NSString *)toString {
    NSMutableString *str = [@"{" mutableCopy];
    NSArray *keys = self.allKeys;
    for (NSString *key in keys) {
        
        id value = [self objectForKey:key];
        
        if ([value isKindOfClass:NSArray.class] || [value isKindOfClass:NSDictionary.class]) {
            value = [value toString];
        }else if ([value isKindOfClass:NSString.class]) {
            value = [NSString stringWithFormat:@"\"%@\"", value];
        }else if ([value isKindOfClass:NSNumber.class]) {
            value = [(NSNumber *)value stringValue];
        }

        [str appendString:[NSString stringWithFormat:@"\"%@\" : %@", key, value]];
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
        id value = [self objectForKey:key];
        if ([value isKindOfClass:NSString.class]) {
            [str appendString:[NSString stringWithFormat:@"%@=%@", key, AFPercentEscapedStringFromString(value)]];
        }else if ([value isKindOfClass:NSArray.class]) {
            NSArray *arr = value;
            for (NSInteger i = 0; i < arr.count; i++) {
                id obj = arr[i];
                if ([obj isKindOfClass:NSString.class]) {
                    [str appendFormat:@"%@=%@", key, AFPercentEscapedStringFromString(obj)];
                }
                if (i != arr.count - 1) {
                    [str appendString:@"&"];
                }
            }
        }
        if (![key isEqualToString:keys.lastObject]) {
            [str appendString:@"&"];
        }
    }
    return str;
}
@end
