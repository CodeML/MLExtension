//
//  UIBarButtonItem+Extension.h
//  iKnowschool
//
//  Created by apple on 2019/5/6.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extension)
+ (instancetype)itemWithIcon:(NSString *)url target:(id)target action:(SEL)action;

+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
