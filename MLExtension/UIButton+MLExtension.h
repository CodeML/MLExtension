//
//  UIButton+MLExtension.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MLButtonStyle) {
    MLButtonStyleNone,              //取消样式
    MLButtonStyleImageMargin,       //图文间隙
    MLButtonStyleImageRight,        //图在右
    MLButtonStyleImageTop,          //图在上
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (MLExtension)
@property (nonatomic, assign) MLButtonStyle style;

+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (instancetype)itemWithIcon:(NSString *)url target:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
