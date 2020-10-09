//
//  UIImage+MLExtension.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KMExtension)
- (NSString *)toBase64;
- (NSString *)toIconBase64;

- (UIImage *)toSize:(CGSize)size;

/**
 模糊处理

 @param blur 模糊等级 0-100 默认10
 @return 模糊后图片
 */
- (instancetype)filterWithBlurLevel:(CGFloat)blur;


/**
 通过颜色创建图片

 @param color 颜色UIColor
 @return image图片
 */
+ (instancetype)imageWithColor:(UIColor *)color;

/**
 缩放图片

 @param scaleSize 缩放比例
 @return 缩放后的图片
 */
- (instancetype)scaleToScale:(CGFloat)scaleSize;
@end

NS_ASSUME_NONNULL_END
