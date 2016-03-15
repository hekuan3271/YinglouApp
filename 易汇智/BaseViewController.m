//
//  BaseViewController.m
//  易汇智
//
//  Created by App on 16/3/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "BaseViewController.h"
#import "SVProgressHUD.h"
#import "UIBarButtonItem+BlocksKit.h"

@interface BaseViewController ()

@end

@implementation BaseViewController{
        NSMutableArray *dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.masksToBounds = YES;
    self.navigationController.navigationBar.barTintColor=color(39, 40, 46, 1);
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes=@{UITextAttributeTextColor: [UIColor whiteColor]};
    if (!self.t_dataSouce) {
        self.t_dataSouce=[[NSMutableArray alloc] init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---push
- (UIViewController *)pushViewController:(NSString *)className{
    return  [self pushViewController:className withParams:nil];
}

- (UIViewController *)pushViewController:(NSString *)className withParams:(NSDictionary *)paramsDict{
    [self hideKeyboard];
    UIViewController *newViewController=[self createViewController:className];
    NSMutableDictionary *mutableDictionary=[paramsDict mutableCopy];
    if ([newViewController isKindOfClass:[BaseViewController class]]) {
        [(BaseViewController *)newViewController setParams:mutableDictionary];
    }
    //统一返回按钮
    WeakSelfType blockSelf=self;
    [self.navigationController pushViewController:newViewController animated:YES];
    return newViewController;
}
- (void)hideKeyboard {
    [self.view endEditing:YES];
}
- (UIViewController *)createViewController:(NSString *)className{
    UIViewController *pushViewController=nil;
    //检测是否有布局
    if (!pushViewController) {
        @try {
            pushViewController=[self.storyboard instantiateViewControllerWithIdentifier:className];
        }
        @catch (NSException *exception) {
            NSLog(@"xib[%@]不存在",className);
        }
        @finally {
            
        }
    }
    //查看是否有class文件，同时兼容xib
    if (!pushViewController) {
        pushViewController=[[NSClassFromString(className) alloc]initWithNibName:nil bundle:nil];
    }
    NSLog(@"进入:%@页面",className);
    self.titles = [NSString stringWithFormat:@"%@",className];
    pushViewController.hidesBottomBarWhenPushed=YES;
    return pushViewController;
}
//返回上一层,最多到根
- (UIViewController *)popViewController{
    [self hideKeyboard];
    if(self.navigationController){
        //得到视图下标
        NSInteger index=[self.navigationController.viewControllers indexOfObject:self];
        UIViewController *newTopViewController=[self.navigationController.viewControllers objectAtIndex:MAX(index-1, 0)];
        [self.navigationController popViewControllerAnimated:YES];
        return newTopViewController;
    }else{
        [self dismissPrestingViewController];
        return self.presentingViewController;
    }
}
//返回到上一层，知道dismiss
- (UIViewController *)backViewController{
    [self hideKeyboard];
    if (self.navigationController) {
        NSInteger index=[self.navigationController.viewControllers indexOfObject:self];
        if (index>0) {  //不是root，就返回到上一级
            UIViewController *presentViewController=[self.navigationController.viewControllers objectAtIndex:MAX(index-1, 0)];
            [self.navigationController popViewControllerAnimated:YES];
            return presentViewController;
        }else{
            [self dismissPrestingViewController];
            return self.presentingViewController;
        }
    }else{
        [self dismissPrestingViewController];
        return  self.presentingViewController;
    }
}
//返回到顶层
- (UIViewController *)popToRootViewController{
    if(self.navigationController){
        UIViewController *newTopViewController=[self.navigationController.viewControllers objectAtIndex:0];
        [self.navigationController popToViewController:newTopViewController animated:YES];
        return newTopViewController;
    }else{
        return nil;
    }
}
- (UIViewController *)presentingViewController:(NSString *)className{
    return [self presentingViewController:className withParams:nil];
}

- (UIViewController *)presentingViewController:(NSString *)className withParams:(NSDictionary *)paramsDict{
    [self hideKeyboard];
    UIViewController *presentViewController=[self createViewController:className];
    NSMutableDictionary *mutalbleDictionary=[NSMutableDictionary dictionaryWithDictionary:paramsDict];
    if ([presentViewController isKindOfClass:[BaseViewController class]]) {
        [(BaseViewController *)presentViewController setParams:[NSDictionary dictionaryWithDictionary:mutalbleDictionary]];
    }
    UINavigationController *navigationController=[[UINavigationController alloc] initWithRootViewController:presentViewController];
    [self.navigationController presentViewController:navigationController animated:YES completion:NULL];
    return navigationController;
}
- (void)dismissPrestedViewController{
    if (self.presentedViewController) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:NULL];
    }
}
- (void)dismissPrestingViewController{
    if (self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }
}
#pragma mark - show &hide
- (void)hideHUDLoading{
    [self hideHUDOnView:self.view];
}

- (void)showResultThenHide:(NSString *)resultString{
    [self showResultThenHide:resultString afterDelay:kHudIntervalNormal onView:self.view];
}
- (void)showResultThenBack:(NSString *)resultString{
    
    [self showResultThenHide:resultString afterDelay:kHudIntervalNormal onView:self.view];
    [self performSelector:@selector(backViewController) withObject:nil afterDelay:kHudIntervalNormal];
}
//延迟隐藏self.view上的hud,返回上一级
- (void)showResultThenPop:(NSString *)resultString {
    [self showResultThenHide:resultString afterDelay:kHudIntervalNormal onView:self.view];
    [self performSelector:@selector(popViewController) withObject:nil afterDelay:kHudIntervalNormal];
}
//隐藏hud的通用方法
- (void)hideHUDOnView:(UIView *)view{
    MBProgressHUD *hud=[MBProgressHUD HUDForView:view];
    [hud hide:YES];
}
//延迟隐藏view上hud的通用方法
- (void)showResultThenHide:(NSString *)resultString afterDelay:(NSTimeInterval)delay onView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.labelText = resultString;
    hud.mode = MBProgressHUDModeText;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}
//在self.view上显示hud
- (MBProgressHUD *)showHUDLoading:(NSString *)hintString {
    return [self showHUDLoading:hintString onView:self.view];
}


//显示hud的通用方法
- (MBProgressHUD *)showHUDLoading:(NSString *)hintString onView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud) {
        [hud show:YES];
    }
    else {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.labelText = hintString;
    hud.mode = MBProgressHUDModeIndeterminate;
    return hud;
}
#pragma mark - alert
- (UIAlertView *)alertViewTitleMessage:(NSString *)alertMessageString{
    return [self alertViewTitle:@"提示" withMessage:alertMessageString];
}
- (UIAlertView *)alertViewTitle:(NSString *)titleMessage withMessage:(NSString *)alertMessageString{
    UIAlertView *alertView=[UIAlertView bk_alertViewWithTitle:titleMessage message:alertMessageString];
    [alertView bk_setCancelButtonWithTitle:@"确定" handler:^{
        
    }];
    [alertView show];
    return alertView;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hideKeyboard];
    return YES;
}

@end
