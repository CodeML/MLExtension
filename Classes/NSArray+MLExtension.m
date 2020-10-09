//
//  NSArray+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "NSArray+KMExtension.h"
#import <MJExtension/MJExtension.h>

@implementation NSArray (KMExtension)
- (NSMutableArray *)toModelArray {
    
    NSDictionary *dict = self.firstObject;
    if ([dict.allKeys containsObject:@"cellModels"]) {
        return [self toModelArr:@"MLBaseTableViewSectionModel"];
    }
    
    return [self toModelArr:@"MLBaseCellModel"];
}

- (NSMutableArray *)toModelArr:(NSString *)modelName {
    return [NSClassFromString(modelName) mj_objectArrayWithKeyValuesArray:self];
}

- (NSString *)toString {
    NSString *str = [NSString stringWithFormat:@"[%@]", [self join:@", \n"]];
    return str;
}

- (NSString *)join:(NSString *)join {
    NSMutableString *strM = [NSMutableString stringWithString:@""];
    if ([self.firstObject isKindOfClass:NSString.class]) {
        // 字符串数组
        for (NSInteger i = 0; i < self.count; i++) {
            NSString *str = self[i];
            [strM appendString:str];
            if (i != self.count - 1) {
                [strM appendString:join];
            }
        }
        return strM;
    } else if ([self.firstObject isKindOfClass:NSDictionary.class]) {
        // 字典数组
        for (NSInteger i = 0; i < self.count; i++) {
            NSString *str = [(NSDictionary *)self[i] toString];
            [strM appendString:str];
            if (i != self.count - 1) {
                [strM appendString:join];
            }
        }
        return strM;
    }
    return @"";
}
@end
