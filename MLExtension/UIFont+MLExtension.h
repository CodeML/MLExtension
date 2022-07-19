//
//  UIFont+MLExtension.h
//  iKnowschool
//
//  Created by apple on 2019/6/13.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (MLExtension)
+ (UIFont *)FONT20;
+ (UIFont *)FONT18;
+ (UIFont *)FONT16;
+ (UIFont *)FONT14;
+ (UIFont *)FONT12;
+ (UIFont *)FONT10;

+ (UIFont *)FONT30_B;
+ (UIFont *)FONT28_B;
+ (UIFont *)FONT20_B;
+ (UIFont *)FONT18_B;
+ (UIFont *)FONT16_B;
+ (UIFont *)FONT14_B;
+ (UIFont *)FONT12_B;
+ (UIFont *)FONT10_B;

+ (UIFont *(^)(CGFloat size, UIFontWeight weight)) font;
+ (UIFont *(^)(CGFloat size)) size;
+ (UIFont *(^)(CGFloat size)) bold;

//UIKIT_EXTERN const UIFontWeight UIFontWeightUltraLight NS_AVAILABLE_IOS(8_2);
//UIKIT_EXTERN const UIFontWeight UIFontWeightThin NS_AVAILABLE_IOS(8_2);
//UIKIT_EXTERN const UIFontWeight UIFontWeightLight NS_AVAILABLE_IOS(8_2);
//UIKIT_EXTERN const UIFontWeight UIFontWeightRegular NS_AVAILABLE_IOS(8_2);
//UIKIT_EXTERN const UIFontWeight UIFontWeightMedium NS_AVAILABLE_IOS(8_2);
//UIKIT_EXTERN const UIFontWeight UIFontWeightSemibold NS_AVAILABLE_IOS(8_2);
//UIKIT_EXTERN const UIFontWeight UIFontWeightBold NS_AVAILABLE_IOS(8_2);
//UIKIT_EXTERN const UIFontWeight UIFontWeightHeavy NS_AVAILABLE_IOS(8_2);
//UIKIT_EXTERN const UIFontWeight UIFontWeightBlack NS_AVAILABLE_IOS(8_2);
@end

NS_ASSUME_NONNULL_END
