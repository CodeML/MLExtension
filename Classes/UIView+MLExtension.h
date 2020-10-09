//
//  UIView+KMViewFrame.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KMViewFrame)
@property (nonatomic, assign) CGFloat left_ml;
@property (nonatomic, assign) CGFloat right_ml;
@property (nonatomic, assign) CGFloat top_ml;
@property (nonatomic, assign) CGFloat bottom_ml;
@property (nonatomic, assign) CGFloat width_ml;
@property (nonatomic, assign) CGFloat height_ml;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size_ml;

@property (nonatomic, strong) NSDictionary *parma;


- (void)addTarget:(nullable id)target action:(SEL)action;
- (void)addBorder:(UIColor *)color;
- (UIView *)addLineWithColor:(UIColor *)color top:(CGFloat)top;
- (UIView *)addBottomLineWithColor:(UIColor *)color;
- (void)removeAllSubView;
- (instancetype)copyNewView;
- (void)addMainColorLayer;
- (void)addLayoutFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;
- (CAGradientLayer *)getMainColorLayer;
- (void)addShadow;
- (void)deleteShadow;

/// 添加部分圆角
/// @param corners 位置
/// @param radius 角度
- (void)cornerRadius:(UIRectCorner)corners radius:(CGFloat)radius;
@end

NS_ASSUME_NONNULL_END
