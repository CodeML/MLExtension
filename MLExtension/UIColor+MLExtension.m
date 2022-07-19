//
//  UIColor+MLExtension.m
//  iKnowschool
//
//  Created by apple on 2019/5/13.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "UIColor+MLExtension.h"

@implementation UIColor (MLExtension)
//获取16进制颜色的方法
+ (UIColor *)hex:(NSString *)hexStr {
    hexStr = [hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([hexStr length] < 6) {
        return nil;
    }
    if ([hexStr hasPrefix:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
    }
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rs = [hexStr substringWithRange:range];
    range.location = 2;
    NSString *gs = [hexStr substringWithRange:range];
    range.location = 4;
    NSString *bs = [hexStr substringWithRange:range];
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rs] scanHexInt:&r];
    [[NSScanner scannerWithString:gs] scanHexInt:&g];
    [[NSScanner scannerWithString:bs] scanHexInt:&b];
    if ([hexStr length] == 8) {
        range.location = 6;
        NSString *as = [hexStr substringWithRange:range];
        [[NSScanner scannerWithString:as] scanHexInt:&a];
    } else {
        a = 255;
    }
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:((float)a / 255.0f)];
}

+ (UIColor *)hex3:(NSString *)hex {
    unsigned int r;
    [[NSScanner scannerWithString:hex] scanHexInt:&r];
   return [UIColor colorWithRed:((float)r / 255.0f) green:((float)r / 255.0f) blue:((float)r / 255.0f) alpha:1];
}

+ (UIColor *)lineColor {
    return [UIColor hex3:@"E9"];
}

+ (UIColor *)black3 {
    return [UIColor hex3:@"33"];
}

+ (UIColor *)black6 {
    return [UIColor hex3:@"66"];
}

+ (UIColor *)black9 {
    return [UIColor hex3:@"99"];
}

+ (UIColor *)blackC {
    return [UIColor hex3:@"CC"];
}

+ (UIColor *)shadowColor {
    return [UIColor colorWithRed:159/255.0 green:131/255.0 blue:131/255.0 alpha:0.22];
}

+ (UIColor *)coverColor {
    return [UIColor colorWithWhite:0 alpha:0.6];
}

+ (UIColor *)mainGreen {
    return [UIColor hex:@"00C692"];
}

+ (UIColor *)mainRed {
    return [UIColor hex:@"D73737"];
}

+ (UIColor *)mainYellow {
    return [UIColor hex:@"FF9900"];
}

+ (UIColor *)mainColor {
    return [UIColor hex:@"008A81"];
}

+ (UIColor *)mainBlue {
    return [UIColor hex:@"0A7AFF"];
}

+ (UIColor *)backClolor {
    return [UIColor hex:@"F3F6F9"];
}

+ (UIColor *)changeColor {
    return [UIColor clearColor];
}

- (BOOL)isEqualColor:(UIColor *)color {
    return CGColorEqualToColor(self.CGColor, color.CGColor);
}
@end
