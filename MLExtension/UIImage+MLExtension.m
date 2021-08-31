//
//  UIImage+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/11/16.
//  Copyright © 2018 90000km. All rights reserved.
//

#import "UIImage+MLExtension.h"

@implementation UIImage (MLExtension)
- (NSString *)toIconBase64 {
    NSData *data = [self compress:200 * 1024];
    NSString *str = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return str;
}

- (NSString *)toBase64 {
    NSData *data = UIImageJPEGRepresentation(self, 0.7);
    NSString *str = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return str;
}

- (NSData *)compress:(NSInteger)size {
    CGFloat proportion = 1.0f;
    NSData *data = UIImageJPEGRepresentation(self, proportion);
    while (data.length > size) {
        proportion -= 0.1;
        if (proportion < 0.1) {
            return data;
        }
        data = UIImageJPEGRepresentation(self, proportion);
    }
    return data;
}

- (UIImage *)toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

- (instancetype)scaleToScale:(CGFloat)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (instancetype)filterWithBlurLevel:(CGFloat)blur {
    // 创建属性
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    // 滤镜效果 高斯模糊
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    // 指定模糊值 默认为10, 范围为0-100
    [filter setValue:[NSNumber numberWithFloat:blur] forKey:@"inputRadius"];
    // 生成图片
    CIContext *context = [CIContext contextWithOptions:nil];
    // 创建输出
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    // 生成CGImageRef
    CGImageRef outImage = [context createCGImage: result fromRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];

    return blurImage;
}
@end
