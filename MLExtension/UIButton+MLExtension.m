//
//  UIButton+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "UIButton+MLExtension.h"
#import <SDWebImage/SDWebImage.h>

@implementation UIButton (MLExtension)
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *item = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [item setTitle:title forState:(UIControlStateNormal)];
    [item setTitleColor:UIColor.black3 forState:(UIControlStateNormal)];
    item.titleLabel.font = UIFont.FONT14;
    [item addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    return item;
}

+ (instancetype)itemWithIcon:(NSString *)url target:(id)target action:(SEL)action {
    
    UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    iconBtn.frame = CGRectMake(0, 0, 30, 30);
    if ([url containsString:@"http"]) {
        iconBtn.contentMode = UIViewContentModeScaleAspectFill;
        [iconBtn sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"HolderImage"]];
    }else{
        [iconBtn setImage:[UIImage imageNamed:url] forState:UIControlStateNormal];
        [iconBtn sizeToFit];
    }
    
    [iconBtn addTarget:target action:action];
    return iconBtn;
}

- (void)setStyle:(MLButtonStyle)style {
    
    switch (style) {
        case MLButtonStyleImageTop:
            // button标题的偏移量
            self.titleEdgeInsets = UIEdgeInsetsMake(self.imageView.height_ml + 5, - self.imageView.width_ml, 0, 0);
            // button图片的偏移量
            self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.width_ml / 2, self.titleLabel.height_ml + 5, - self.titleLabel.width_ml / 2);
            break;
        case MLButtonStyleImageRight:
            // button标题的偏移量
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - self.imageView.width_ml + 5, 0, self.imageView.width_ml);
             
            // button图片的偏移量
            self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.width_ml, 0, - self.titleLabel.width_ml);
            break;
        case MLButtonStyleImageMargin:
            //button标题的偏移量，这个偏移量是相对于图片的
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            break;
            
        default:
            self.titleEdgeInsets = self.imageEdgeInsets = UIEdgeInsetsZero;
            break;
    }
    
    
}
@end
