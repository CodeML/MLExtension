//
//  UIBarButtonItem+MLExtension.m
//  iKnowschool
//
//  Created by apple on 2019/5/6.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "UIBarButtonItem+MLExtension.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "UIImage+MLExtension.h"
#import "UIView+MLExtension.h"
#import "UIColor+MLExtension.h"

@implementation UIBarButtonItem (MLExtension)

+ (instancetype)itemWithIcon:(NSString *)url target:(id)target action:(SEL)action {    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    if ([url containsString:@"http"]) {
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"HolderImage"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            imageView.image = [image toSize:CGSizeMake(30, 30)];
        }];
        imageView.layer.cornerRadius = 15;
        imageView.layer.masksToBounds = YES;
    }else{
        imageView.image = [UIImage imageNamed:url];
        [imageView sizeToFit];
    }
    
    [imageView addTarget:target action:action];
    return [[UIBarButtonItem alloc] initWithCustomView:imageView];
}

+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *item = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [item setTitle:title forState:(UIControlStateNormal)];
    [item setTitleColor:UIColor.black3 forState:(UIControlStateNormal)];
    [item addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}
@end
