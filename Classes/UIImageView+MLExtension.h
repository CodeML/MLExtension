//
//  UIImageView+Extension.h
//  iKnowschool
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Extension)
- (instancetype)toCircle;
+ (instancetype)dottedLine:(CGRect)frame;
+ (instancetype)dottedLine:(CGRect)frame lineColor:(UIColor *)color;
- (void)startAnimation:(NSArray <UIImage *>*)images;
- (void)stopAnimation:(UIImage *)hold;
@end

NS_ASSUME_NONNULL_END
