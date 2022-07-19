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
#import <Masonry/Masonry.h>

@implementation UIView (MLExtension)

static char badgeValueLabelKey;

- (UIImage *)toImage {
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

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

- (void)setBadgeValue:(NSString *)badgeValue {
    self.badgeValueLabel.text = badgeValue;
    self.badgeValueLabel.hidden = !badgeValue.integerValue;
}

- (NSString *)badgeValue {
    return self.badgeValueLabel.text;
}

- (void)setBadgeValueLabel:(UILabel *)badgeValueLabel {
    //移除已存在的label
    UILabel *label = objc_getAssociatedObject(self, &badgeValueLabelKey);
    if (label) { [label removeFromSuperview]; }
    
    //绑定新的label
    objc_setAssociatedObject(self,&badgeValueLabelKey, badgeValueLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //添加label到view
    badgeValueLabel.hidden = !self.badgeValue.length;
    badgeValueLabel.text = self.badgeValue;
    [self addSubview:badgeValueLabel];
}

- (UILabel *)badgeValueLabel {
    UILabel *label = objc_getAssociatedObject(self, &badgeValueLabelKey);
    if (!label) {
        UILabel *label = [UILabel new];
        label.layer.cornerRadius = 10;
        label.layer.masksToBounds = YES;
        label.textColor = SCC_Hex(@"FFFFFF");
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = SCC_Hex(@"D73737");
        label.font = SCC_Font(10);
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(-10);
            make.trailing.equalTo(self).offset(10);
            make.width.height.mas_equalTo(20);
        }];
        objc_setAssociatedObject(self, &badgeValueLabelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
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
    self.layer.cornerRadius = 2;
}

- (UIView *)addLineWithColor:(UIColor *)color top:(CGFloat)top {
    if (!top) top = 0.5;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, top - 0.5, self.width_ml, 0.5)];
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

- (CAGradientLayer *)addLayerFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor point:(CGRect)points {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.startPoint = CGPointMake(points.origin.x, points.origin.y);
    gradientLayer.endPoint = CGPointMake(points.size.width, points.size.height);
    gradientLayer.locations = @[@(0),@(1.0f)];
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
    [self.layer insertSublayer:gradientLayer atIndex:0];
    return gradientLayer;
}

- (CAGradientLayer *)addLayerFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor {
    return [self addLayerFromColor:fromColor toColor:toColor point:CGRectMake(0, 0, 1, 1)];
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
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 13;
    self.layer.shadowOffset = CGSizeMake(0, -2);
}

- (void)addShadowWithColor:(UIColor *)color {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 13;
    self.layer.shadowOffset = CGSizeMake(0, -2);
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

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param self:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
- (CAShapeLayer *)drawDashLineLength:(NSInteger)lineLength lineSpacing:(NSInteger)lineSpacing lineColor:(UIColor *)lineColor isHorizonal:(BOOL)isHorizonal {
 
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
 
    [shapeLayer setBounds:self.bounds];
 
    if (isHorizonal) {
 
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
 
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/2)];
    }
 
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    } else {
 
        [shapeLayer setLineWidth:CGRectGetWidth(self.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:@[@(lineLength), @(lineSpacing)]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
 
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(self.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(self.frame));
    }
 
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}

- (void)addUnreadNum:(NSInteger)num height:(CGFloat)height {
    UILabel *numLab = [self viewWithTag:12580];
    if (!numLab) {
        numLab = UILabel.new;
        numLab.tag = 12580;
        numLab.backgroundColor = UIColor.mainRed;
        numLab.textColor = UIColor.whiteColor;
        numLab.font = UIFont.size(9);
        numLab.textAlignment = NSTextAlignmentCenter;
        [self insertSubview:numLab atIndex:0];
    }
    if (num <= 0) {
        [numLab removeFromSuperview];
        return;
    }else if (num > 99) {
        numLab.text = @"99+";
    }else{
        numLab.text = [NSString stringWithFormat:@"%zi", num];
    }
    
    [numLab sizeToFit];
    numLab.width_ml += 7;
    numLab.height_ml = height;
    
    if (numLab.width_ml < height) {
        numLab.width_ml = height;
    }
    numLab.layer.cornerRadius = height * 0.5;
    numLab.layer.masksToBounds = true;
    numLab.right_ml = self.width_ml - 5;
    numLab.top_ml = 2;
}

- (void)borderWithDirection:(MLDirection)direction borderColor:(UIColor *)color borderWidth:(CGFloat)width {
    if ((direction & MLDirectionTop) == MLDirectionTop) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.width_ml, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if ((direction & MLDirectionLeft) == MLDirectionLeft) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, self.height_ml);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if ((direction & MLDirectionBottom) == MLDirectionBottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.height_ml - width, self.width_ml, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if ((direction & MLDirectionRight) == MLDirectionRight) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.width_ml - width, 0, width, self.height_ml);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
}

@end
