//
//  UIImageView+MLExtension.m
//  iKnowschool
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "UIImageView+MLExtension.h"
#import "UIView+MLExtension.h"
#import "UIColor+MLExtension.h"

@implementation UIImageView (MLExtension)
- (instancetype)toCircle {
    self.layer.cornerRadius = self.width_ml * 0.5;
    self.layer.masksToBounds = YES;
    return self;
}

+ (instancetype)dottedLine:(CGRect)frame {
    return [UIImageView dottedLine:frame lineColor:UIColor.lineColor];
}

+ (instancetype)dottedLine:(CGRect)frame lineColor:(UIColor *)color {
    UIImageView *v = [[UIImageView alloc] initWithFrame:frame];
    v.image = [v drawLineByImageView:color];
    return v;
}

// 返回虚线image的方法
- (UIImage *)drawLineByImageView:(UIColor *)lineColor {
    UIGraphicsBeginImageContext(self.size_ml); //开始画线 划线的frame
    [self.image drawInRect:self.bounds];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度 1是高度
    CGFloat lengths[] = {10,5};
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 线宽
    CGContextSetLineWidth(context, self.height_ml);
    // 设置颜色
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineDash(context, 0, lengths, 2); //画虚线
    CGContextMoveToPoint(context, 0.0, self.height_ml * 0.5); //开始画线
    CGContextAddLineToPoint(context, self.width_ml, self.height_ml * 0.5);
    
    CGContextStrokePath(context);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (void)startAnimation:(NSArray<UIImage *> *)images {
    self.animationImages = images;
    
    // 次数
    self.animationRepeatCount = -1;
    
    // 时长, 1秒30帧
    self.animationDuration = 1.0;
    
    [self startAnimating];
}

- (void)stopAnimation:(UIImage *)hold {
    [self stopAnimating];
    self.image = hold;
}
@end
