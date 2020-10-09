//
//  MBProgressHUD+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "MBProgressHUD+MLExtension.h"
#import "UIColor+MLExtension.h"

@implementation MBProgressHUD (MLExtension)

+ (instancetype)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    __block UIView *v = view;
    __block MBProgressHUD *hud = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (v == nil)
            v = [[UIApplication sharedApplication].windows lastObject];
        
        hud = [MBProgressHUD showHUDAddedTo:v animated:YES];
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
        hud.mode = MBProgressHUDModeCustomView;
        hud.bezelView.backgroundColor = UIColor.blackColor;
        hud.label.text = text;
        hud.label.textColor = UIColor.whiteColor;
        
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hideAnimated:YES afterDelay:1.f];
    });
    return hud;
}

+ (instancetype)showSuccess:(NSString *)success
{
    return [self showSuccess:success toView:nil];
}

+ (instancetype)showSuccess:(NSString *)success toView:(UIView *)view
{
    return [self show:success icon:@"success" view:view];
}

+ (instancetype)showError:(NSString *)error
{
    return [self showError:error toView:nil];
}

+ (instancetype)showError:(NSString *)error toView:(UIView *)view{
    return [self show:error icon:@"error" view:view];
}

+ (instancetype)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}


+ (instancetype)showMessage:(NSString *)message toView:(UIView *)view {
    __block UIView *v = view;
    __block MBProgressHUD *hud = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (v == nil) {
            v = [[UIApplication sharedApplication].windows lastObject];
        }
        hud = [MBProgressHUD showHUDAddedTo:v animated:YES];
        hud.bezelView.backgroundColor = UIColor.shadowColor;
        hud.label.text = message;
        hud.contentColor = UIColor.whiteColor;
        hud.removeFromSuperViewOnHide = YES;
    });
    return hud;
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    
    __block UIView *v = view;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (v == nil) {
            v = [[UIApplication sharedApplication].windows lastObject];
        }
       [self hideHUDForView:v animated:YES];
    });
}
@end
