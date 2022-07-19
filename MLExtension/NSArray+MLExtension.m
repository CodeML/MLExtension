//
//  NSArray+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "NSArray+MLExtension.h"
#import "NSDictionary+MLExtension.h"
//#import <MJExtension/MJExtension.h>

@implementation NSArray (MLExtension)
- (NSMutableArray *)toModelArray {
    
    NSDictionary *dict = self.firstObject;
    if ([dict.allKeys containsObject:@"cellModels"]) {
        return [self toModelArr:@"MLBaseTableViewSectionModel"];
    }
    
    return [self toModelArr:@"MLBaseCellModel"];
}

- (NSMutableArray *)toModelArr:(NSString *)modelName {
    return [NSArray modelArrayWithClass:NSClassFromString(modelName) json:self].mutableCopy;
}

- (NSString *)toString {
    NSString *str = [NSString stringWithFormat:@"[%@]", [self join:@", \n"]];
    return str;
}

- (NSString *)join:(NSString *)join {
    NSMutableString *strM = [NSMutableString stringWithString:@""];
    
    for (NSInteger i = 0; i < self.count; i++) {
        NSString *str = @"";
        
        if ([self.firstObject isKindOfClass:NSString.class]) {
            // 字符串数组
            str = self[i];
        } else if ([self.firstObject isKindOfClass:NSDictionary.class]) {
            // 字典数组
            str = [(NSDictionary *)self[i] toString];
        } else if ([self.firstObject isKindOfClass:NSArray.class]) {
            // 数组嵌套
            str = [(NSArray *)self[i] toString];
        }
        
        [strM appendString:str];
        if (i != self.count - 1) {
            [strM appendString:join];
        }
    }
    return strM;
}
@end
