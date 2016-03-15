//
//  BaseViewController.h
//  易汇智
//
//  Created by App on 16/3/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <BlocksKit+UIKit.h>

#define kHudIntervalNormal 1.0f
@interface BaseViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) NSDictionary *params;//切换视图所传入的参数
@property (nonatomic, strong) NSString *titles;
@property (nonatomic,strong) NSMutableArray *t_dataSouce;
#pragma mark - push
- (UIViewController *)pushViewController:(NSString *)className;
- (UIViewController *)pushViewController:(NSString *)className withParams:(NSDictionary *)paramsDict;

//返回上一级，最多到根
- (UIViewController *)popViewController;
//返回上一层，知道dismiss
- (UIViewController *)backViewController;
//返回到根
- (UIViewController *)popToRootViewController;
#pragma mark - present
- (UIViewController *)presentingViewController:(NSString *)className;
- (UIViewController *)presentingViewController:(NSString *)className withParams:(NSDictionary *)paramsDict;
- (void)dismissPrestedViewController;
- (void)dismissPrestingViewController;

#pragma mark show&hide
- (MBProgressHUD *)showHUDLoading:(NSString *)hintString;
- (void)hideHUDLoading;
- (void)showResultThenHide:(NSString *)resultString;
- (void)showResultThenBack:(NSString *)resultString;
- (void)showResultThenPop:(NSString *)resultString;

#pragma mark - alertView
- (UIAlertView *)alertViewTitleMessage:(NSString *)alertMessageString;
- (UIAlertView *)alertViewTitle:(NSString *)titleMessage withMessage:(NSString *)alertMessageString;
@end
