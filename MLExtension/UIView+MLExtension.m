//
//  UIView+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "UIView+MLExtension.h"
#import "UIColor+MLExtension.h"
#import <objc/runtime.h>

@implementation UIView (MLExtension)

- (void)setParma:(NSDictionary *)parma {
    objc_setAssociatedObject(self, @selector(parma), parma, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)parma {
    id objc = objc_getAssociatedObject(self, @selector(parma));
    if (!objc) {
        objc = @{};
    }
    return (NSDictionary *)objc;
}

- (void)setTop_ml:(CGFloat)top_ml {
    CGRect frame = self.frame;
    frame.origin.y = top_ml;
    self.frame = frame;
}

- (CGFloat)top_ml {
    return self.frame.origin.y;
}

- (void)setBottom_ml:(CGFloat)bottom_ml {
    CGRect frame = self.frame;
    frame.origin.y = bottom_ml - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom_ml {
    return CGRectGetMaxY(self.frame);
}

- (void)setLeft_ml:(CGFloat)left_ml {
    CGRect frame = self.frame;
    frame.origin.x = left_ml;
    self.frame = frame;
}

- (CGFloat)left_ml {
    return self.frame.origin.x;
}

- (void)setRight_ml:(CGFloat)right_ml {
    CGRect frame = self.frame;
    frame.origin.x = right_ml - frame.size.width;
    self.frame = frame;
}

- (CGFloat)right_ml {
    return CGRectGetMaxX(self.frame);
}

- (void)setWidth_ml:(CGFloat)width_ml {
    CGRect frame = self.frame;
    frame.size.width = width_ml;
    self.frame = frame;
}

- (CGFloat)width_ml {
    return self.frame.size.width;
}

- (void)setHeight_ml:(CGFloat)height_ml {
    CGRect frame = self.frame;
    frame.size.height = height_ml;
    self.frame = frame;
}

- (CGFloat)height_ml {
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setSize_ml:(CGSize)size_ml {
    CGRect frame = self.frame;
    frame.size = size_ml;
    self.frame = frame;
}

- (CGSize)size_ml {
    return self.frame.size;
}

- (void)addTarget:(id)target action:(SEL)action {
    if ([self isKindOfClass:UIButton.class]) {
        [(UIButton *)self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }else{
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    }
}

- (void)addBorder:(UIColor *)color {
    self.layer.borderWidth = 1;
    self.layer.borderColor = color.CGColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;
}

- (UIView *)addLineWithColor:(UIColor *)color top:(CGFloat)top {
    if (!top) top = 1;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, top - 1, self.width_ml, 1)];
    line.backgroundColor = color;
    [self addSubview:line];
    return line;
}

- (UIView *)addBottomLineWithColor:(UIColor *)color {
    return [self addLineWithColor:color top:self.height_ml];
}

- (void)removeAllSubView {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (instancetype)copyNewView {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self]; //12.0以前
    return [NSKeyedUnarchiver unarchiveObjectWithData:data]; //12.0以前
}

- (void)addLayoutFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.locations = @[@(0),@(1.0f)];
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
    [self.layer addSublayer:gradientLayer];
}

- (void)addMainColorLayer {
    CAGradientLayer *gradientLayer = [self getMainColorLayer];
    [self.layer addSublayer:gradientLayer];
}

- (CAGradientLayer *)getMainColorLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.locations = @[@(0),@(1.0f)];
    gradientLayer.colors = @[(__bridge id)UIColor.mainColor.CGColor,(__bridge id)UIColor.mainColor.CGColor];
    return gradientLayer;
}

- (void)addShadow {
    self.layer.shadowColor = UIColor.shadowColor.CGColor;
    self.layer.shadowOpacity = 0.3f;
    self.layer.shadowRadius = 3;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.masksToBounds = false;
    self.layer.cornerRadius = 5;
}

- (void)deleteShadow {
    self.layer.shadowColor = nil;
    self.layer.shadowOpacity = 0;
    self.layer.shadowRadius = 0;
    self.layer.shadowOffset = CGSizeMake(0, 0);
}

- (void)cornerRadius:(UIRectCorner)corners radius:(CGFloat)radius {

    CGSize size = CGSizeMake(radius,radius);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    
    CAShapeLayer *layer = CAShapeLayer.new;
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}
@end
