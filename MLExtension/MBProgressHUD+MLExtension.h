//
//  MBProgressHUD+MLExtension.h
//  KMAirTicket
//
//  Created by apple on 2019/5/7.
//  Copyright © 2019 cassim. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (MLExtension)

/**
 显示成功

 @param success 成功提示文本
 */
+ (instancetype)showSuccess:(NSString *)success;

/**
 显示成功到视图

 @param success 成功提示文本
 @param view 显示到的视图
 */
+ (instancetype)showSuccess:(NSString *)success toView:(UIView *)view;

/**
 显示失败

 @param error 失败提示文本
 */
+ (instancetype)showError:(NSString *)error;

/**
 显示失败到视图

 @param error 失败提示文本
 @param view 显示到的视图
 */
+ (instancetype)showError:(NSString *)error toView:(UIView *)view;

/**
 显示等待

 @param message 等待提示文本
 @return 返回提示对象
 */
+ (instancetype)showMessage:(NSString *)message;

/**
 显示等待

 @param message 等待提示文本
 @param view 显示到的视图
 @return 返回提示对象
 */
+ (instancetype)showMessage:(NSString *)message toView:(UIView *)view;


/// 显示弹框到视图
/// @param text 标题文本
/// @param subStr 详情文本
/// @param icon 图标名
/// @param view 显示到的视图
+ (instancetype)show:(NSString *)text sub:(NSString *)subStr icon:(NSString *)icon view:(UIView *)view;

+ (instancetype)show:(NSString *)text sub:(NSString *)subStr icon:(NSString *)icon view:(UIView *)view darkMode:(BOOL)darkMode;

/**
 隐藏提示
 */
+ (void)hideHUD;

/**
 隐藏视图中的提示

 @param view 隐藏提示的视图
 */
+ (void)hideHUDForView:(UIView *)view;
@end
