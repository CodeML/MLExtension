//
//  MBProgressHUD+MLExtension.m
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import "MBProgressHUD+MLExtension.h"
#import "UIColor+MLExtension.h"
#import "UIFont+MLExtension.h"

@implementation MBProgressHUD (MLExtension)

+ (instancetype)show:(NSString *)text sub:(NSString *)subStr icon:(NSString *)icon view:(UIView *)view
{
    return [self show:text sub:subStr icon:icon view:view darkMode:YES];
}

+ (instancetype)show:(NSString *)text sub:(NSString *)subStr icon:(NSString *)icon view:(UIView *)view darkMode:(BOOL)darkMode
{
    __block UIView *v = view;
    __block MBProgressHUD *hud = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (v == nil)
            v = [[UIApplication sharedApplication].windows lastObject];
        
        hud = [MBProgressHUD showHUDAddedTo:v animated:YES];
        hud.contentColor = darkMode ? [UIColor whiteColor] : [UIColor blackColor];
        
        if (icon.length) {
            hud.customView = [[UIImageView alloc] initWithImage:SCC_Image(icon)];
        }
        hud.mode = MBProgressHUDModeCustomView;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = darkMode ? SCC_HexAlpha(@"000000", 0.75) : SCC_Hex(@"FFFFFF");
        
        //标题
        if (text.length) {
            hud.label.text = text;
            hud.label.numberOfLines = 0;
            hud.label.font = UIFont.font(16, UIFontWeightSemibold);
        }
        
        //子标题
        if (subStr.length) {
            hud.detailsLabel.text = subStr;
            hud.detailsLabel.textColor = UIColor.whiteColor;
            hud.detailsLabel.font = UIFont.size(16);
        }
        
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hideAnimated:YES afterDelay:1.5f];
    });
    return hud;
}

+ (instancetype)showSuccess:(NSString *)success
{
    return [self showSuccess:success toView:nil];
}

+ (instancetype)showSuccess:(NSString *)success toView:(UIView *)view
{
    return [self show:success sub:nil icon:@"success" view:view];
}

+ (instancetype)showError:(NSString *)error
{
    return [self showError:error toView:nil];
}

+ (instancetype)showError:(NSString *)error toView:(UIView *)view{
    return [self show:error sub:nil icon:@"error" view:view];
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
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
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
