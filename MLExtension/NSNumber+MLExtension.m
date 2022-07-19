//
//  NSNumber+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "NSNumber+MLExtension.h"

@implementation NSNumber (MLExtension)
- (NSString *)toString {
    return [NSString stringWithFormat:@"%@", self];
}

- (NSString *)priceString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.positiveFormat = @"###,###,###,##0.00";
    return [formatter stringFromNumber:self];
}

- (CGFloat)realSize {
    double proportion = UIScreen.mainScreen.bounds.size.width / 375;
    return proportion * self.doubleValue;
}

//
//    NSNumberFormatterNoStyle = kCFNumberFormatterNoStyle, //无格式,四舍五入，原值2.7999999999,直接输出3
//    NSNumberFormatterDecimalStyle = kCFNumberFormatterDecimalStyle, //小数型,保留小数输出2.8
//    NSNumberFormatterCurrencyStyle = kCFNumberFormatterCurrencyStyle, //货币型,加上了人民币标志，原值输出￥2.8
//    NSNumberFormatter
//    NSNumberFormatterPercentStyle = kCFNumberFormatterPercentStyle,  //百分比型,本身数值乘以100后用百分号表示,输出280%
//    NSNumberFormatterScientificStyle = kCFNumberFormatterScientificStyle, //科学计数型,原值表示，输出2.799999999E0
//    NSNumberFormatterSpellOutStyle = kCFNumberFormatterSpellOutStyle  //全拼,原值的中文表示，输出二点七九九九...
- (NSString *)changeStyle:(NSNumberFormatterStyle)style {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = style;
    return [formatter stringFromNumber:self];
}

- (NSString *)changeToumberFormatterNoStyle {
    return [self changeStyle:NSNumberFormatterNoStyle];
}

- (NSString *)changeToNumberFormatterDecimalStyle {
    return [self changeStyle:NSNumberFormatterDecimalStyle];
}

- (NSString *)changeToNumberFormatterCurrencyStyle {
    return [self changeStyle:NSNumberFormatterCurrencyStyle];
}

- (NSString *)changeToNumberFormatterPercentStyle {
    return [self changeStyle:NSNumberFormatterPercentStyle];
}

- (NSString *)changeToNumberFormatterScientificStyle {
    return [self changeStyle:NSNumberFormatterScientificStyle];
}

- (NSString *)changeToNumberFormatterSpellOutStyle {
    return [self changeStyle:NSNumberFormatterSpellOutStyle];
}

- (NSNumber *)resultWithOperators:(ML_OPERATORS)opera num:(NSNumber *)num {
    NSDecimalNumber *resultNum = [[NSDecimalNumber alloc] init];
    NSDecimalNumber *A = [NSDecimalNumber decimalNumberWithDecimal:self.decimalValue];
    NSDecimalNumber *B = [NSDecimalNumber decimalNumberWithDecimal:num.decimalValue];
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                           scale:2
                                                raiseOnExactness:NO
                                                 raiseOnOverflow:NO
                                                raiseOnUnderflow:NO
                                             raiseOnDivideByZero:NO];

    if (opera == ML_Add) {
        resultNum = [A decimalNumberByAdding:B withBehavior:roundingBehavior];
    }else if (opera == ML_Sub) {
        // 减法
        resultNum = [A decimalNumberBySubtracting:B withBehavior:roundingBehavior];
    }else if (opera == ML_Mul) {
        resultNum = [A decimalNumberByMultiplyingBy:B withBehavior:roundingBehavior];
    }else if (opera == ML_Div) {
        // 除法
        resultNum = [A decimalNumberByDividingBy:B withBehavior:roundingBehavior];
    }
    return resultNum;
}
@end
