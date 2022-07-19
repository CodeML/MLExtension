//
//  UINavigationController+MLExtension.h
//  SpeedCarConnecting
//
//  Created by 魏明磊 on 2022/7/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (MLExtension)
- (BOOL)checkController:(NSString *)className;

- (void)removeController:(NSString *)vcName;
@end

NS_ASSUME_NONNULL_END
