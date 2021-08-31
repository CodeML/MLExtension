//
//  UIColor+MLExtension.h
//  iKnowschool
//
//  Created by apple on 2019/5/13.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MLExtension)
+ (UIColor *)backClolor;
+ (UIColor *)shadowColor;
+ (UIColor *)lineColor;
+ (UIColor *)mainColor;
+ (UIColor *)mainGreen;
+ (UIColor *)mainRed;
+ (UIColor *)linkClolor;
//渐变色
+ (UIColor *)changeColor;
+ (UIColor *)black3;
+ (UIColor *)black6;
+ (UIColor *)black9;
+ (UIColor *)hex:(NSString *)hexStr;
+ (UIColor *)hex3:(NSString *)hex;
- (BOOL)isEqualColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
