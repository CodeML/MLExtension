//
//  UIView+MLExtension.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCCRectFrameOffset(View,offsetX,offsetY,offsetW,offsetH) [View setFrame:CGRectMake(offsetX+View.frame.origin.x, offsetY+View.frame.origin.y, offsetW+View.frame.size.width, offsetH+View.frame.size.height)]

typedef NS_OPTIONS(NSUInteger, MLDirection) {
    MLDirectionTop      = 1 << 0, //  0001  1
    MLDirectionLeft     = 1 << 1, //  0010  2
    MLDirectionBottom   = 1 << 2, //  0100  4
    MLDirectionRight    = 1 << 3, //  1000  8
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MLExtension)
@property (nonatomic, assign) CGFloat left_ml;
@property (nonatomic, assign) CGFloat right_ml;
@property (nonatomic, assign) CGFloat top_ml;
@property (nonatomic, assign) CGFloat bottom_ml;
@property (nonatomic, assign) CGFloat width_ml;
@property (nonatomic, assign) CGFloat height_ml;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size_ml;

@property (nonatomic, strong) UILabel *badgeValueLabel;
@property (nonatomic, strong) NSString *badgeValue;
@property (nonatomic, strong) NSDictionary *parma;

- (UIImage *)toImage;
- (void)addTarget:(nullable id)target action:(SEL)action;
- (void)addBorder:(UIColor *)color;
- (UIView *)addLineWithColor:(UIColor *)color top:(CGFloat)top;
- (UIView *)addBottomLineWithColor:(UIColor *)color;
- (void)removeAllSubView;
- (instancetype)copyNewView;
- (void)addMainColorLayer;
- (CAGradientLayer *)addLayerFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;
- (CAGradientLayer *)addLayerFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor point:(CGRect)points;
- (CAGradientLayer *)getMainColorLayer;
- (void)addShadow;
- (void)addShadowWithColor:(UIColor *)color;
- (void)deleteShadow;

- (void)addUnreadNum:(NSInteger)num height:(CGFloat)height;

/// 添加部分圆角
/// @param corners 位置
/// @param radius 角度
- (void)cornerRadius:(UIRectCorner)corners radius:(CGFloat)radius;

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param self:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
- (CAShapeLayer *)drawDashLineLength:(NSInteger)lineLength lineSpacing:(NSInteger)lineSpacing lineColor:(UIColor *)lineColor isHorizonal:(BOOL)isHorizonal;

/**
 *  添加部分方向的border
 *
 *  param direction:       需要添加border的方向
 *  param color:     border的颜色
 *  param width:    border的宽度
 **/
- (void)borderWithDirection:(MLDirection)direction borderColor:(UIColor *)color borderWidth:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
