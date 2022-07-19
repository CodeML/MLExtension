//
//  UINavigationController+MLExtension.m
//  SpeedCarConnecting
//
//  Created by 魏明磊 on 2022/7/8.
//

#import "UINavigationController+MLExtension.h"

@implementation UINavigationController (MLExtension)
- (BOOL)checkController:(NSString *)className {
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(className)]) {
            return true;
        }
    }
    return false;
}

- (void)removeController:(NSString *)vcName {
    NSMutableArray *marr = self.navigationController.viewControllers.mutableCopy;
    
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:NSClassFromString(vcName)]) {
            [marr removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = marr;
}
@end
