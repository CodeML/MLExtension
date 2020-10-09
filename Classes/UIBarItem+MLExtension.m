//
//  UIBarItem+Extension.m
//  iKnowschool
//
//  Created by apple on 2019/10/18.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "UIBarItem+Extension.h"

@implementation UIBarItem (Extension)
- (UIView *)view_ml {
    return [self valueForKey:@"view"];
}
@end
