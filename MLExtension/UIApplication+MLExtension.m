//
//  UIApplication+MLExtension.m
//  SpeedCarConnecting
//
//  Created by 魏明磊 on 2021/12/20.
//

#import "UIApplication+MLExtension.h"

@implementation UIApplication (MLExtension)
- (UIWindow *)keyWindow {
    return self.windows.lastObject;
}
@end
