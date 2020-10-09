//
//  UIBarItem+MLExtension.m
//  iKnowschool
//
//  Created by apple on 2019/10/18.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "UIBarItem+MLExtension.h"

@implementation UIBarItem (MLExtension)
- (UIView *)view_ml {
    return [self valueForKey:@"view"];
}
@end
