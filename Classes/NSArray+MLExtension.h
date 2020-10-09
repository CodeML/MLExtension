//
//  NSArray+MLExtension.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (KMExtension)
- (NSMutableArray *)toModelArray;
- (NSMutableArray *)toModelArr:(NSString *)modelName;

/**
 数组转字符串

 @return 默认", "分割且带"["和"]"的字符串
 */
- (NSString *)toString;

/**
 数组转字符串

 @param str 分割字符
 @return 不带"["和"]"的字符串
 */
- (NSString *)join:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
