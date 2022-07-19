//
//  NSNumber+MLExtension.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ML_OPERATORS){
    ML_Add,//加
    ML_Mul,//乘
    ML_Sub,//减
    ML_Div//除
};

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (MLExtension)
- (NSString *)toString;
- (NSString *)priceString;
- (CGFloat)realSize;

//无格式,四舍五入
- (NSString *)changeToumberFormatterNoStyle;
//小数型,
- (NSString *)changeToNumberFormatterDecimalStyle;
//货币型,
- (NSString *)changeToNumberFormatterCurrencyStyle;
//百分比型
- (NSString *)changeToNumberFormatterPercentStyle;
//科学计数型,
- (NSString *)changeToNumberFormatterScientificStyle;
//全拼
- (NSString *)changeToNumberFormatterSpellOutStyle;


/// 运算方法
/// @param opera 运算方式
/// @param num 第二个数
- (NSNumber *)resultWithOperators:(ML_OPERATORS)opera num:(NSNumber *)num;

@end

NS_ASSUME_NONNULL_END
