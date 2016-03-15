//
//  UIView+Addition.m
//  GeneralFramework
//
//  Created by ZMJ on 15/4/19.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)

+ (void)makeCircleForImageView:(UIImageView *)imageView{
    imageView.layer.cornerRadius = imageView.bounds.size.width / 2;
    imageView.layer.masksToBounds = YES;
}
+ (UIActionSheet *)showImagePickerActionSheetDelegate:(id<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CTAssetsPickerControllerDelegate>)delegate
                                        allowsEditing:(BOOL)allowsEditing
                                          allowsImage:(BOOL)allowsImage
                                          allowsVideo:(BOOL)allowsVideo
                                      numberOfSection:(NSInteger)numberOfSection
                                         viewControls:(UIViewController *)viewsController{
    UIActionSheet *sheet=[UIActionSheet bk_actionSheetWithTitle:nil];
    if (allowsVideo) {
        [sheet bk_addButtonWithTitle:@"本地视频" handler:^{
            CTAssetsPickerController *pickerController=[[CTAssetsPickerController alloc] init];
            pickerController.delegate=delegate;
            pickerController.maximumNumberOfSelection=numberOfSection;
            pickerController.assetsFilter = [ALAssetsFilter allVideos];
            [viewsController presentViewController:pickerController animated:YES completion:nil];
        }];
    }
    [sheet bk_addButtonWithTitle:@"本地图片" handler:^{
        UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
            [UIView showResultThenHide:@"您的设备无法获取"];
            return ;
        }else{
            if (allowsImage) {
                UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
                imagePickerController.delegate=delegate;
                imagePickerController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
                imagePickerController.sourceType=sourceType;
                imagePickerController.allowsEditing=allowsEditing;
                [viewsController presentViewController:imagePickerController animated:YES completion:nil];
            }else{
                CTAssetsPickerController *pickerController=[[CTAssetsPickerController alloc] init];
                pickerController.delegate=delegate;
                pickerController.maximumNumberOfSelection=numberOfSection;
                pickerController.assetsFilter = [ALAssetsFilter allPhotos];
                [viewsController presentViewController:pickerController animated:YES completion:nil];
            }
        }
    }];
    [sheet bk_addButtonWithTitle:@"拍照" handler:^{
        UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
            //不支持
            [UIView showResultThenHide:@"您的设备无法获取"];
            return ;
        }else{
            UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
            imagePickerController.delegate=delegate;
            imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            imagePickerController.allowsEditing=allowsEditing;
            imagePickerController.sourceType=sourceType;
            [viewsController presentViewController:imagePickerController animated:YES completion:nil];
        }
    }];
    [sheet bk_addButtonWithTitle:@"取消" handler:nil];
    [sheet showInView:viewsController.view.window];
    return sheet;
}


#pragma mark - 图片选择器
+ (UIActionSheet *)showImagePickerActionSheetWithDelegate:(id<UINavigationControllerDelegate,
                                                           UIImagePickerControllerDelegate,
                                                           ZYQAssetPickerControllerDelegate>)delegate
                                            allowsEditing:(BOOL)allowsEditing
                                              singleImage:(BOOL)singleImage
                                        numberOfSelection:(NSInteger)numberOfSelection
                                         onViewController:(UIViewController *)viewController {
    UIActionSheet *actionSheet = [UIActionSheet bk_actionSheetWithTitle:nil];
    [actionSheet bk_addButtonWithTitle:@"拍摄照片"
                               handler:^{
                                   UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                                   if ( ! [UIImagePickerController isSourceTypeAvailable:sourceType]) {
                                       [UIView showResultThenHide:@"您的设备无法通过此方式获取照片"];
                                       return;
                                   }
                                   else {
                                       UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                                       imagePickerController.delegate = delegate;
                                       imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                                       imagePickerController.allowsEditing = allowsEditing;
                                       imagePickerController.sourceType = sourceType;
                                       [viewController presentViewController:imagePickerController animated:YES completion:nil];
                                   }
                               }];
    
    [actionSheet bk_addButtonWithTitle:@"选取照片"
                               handler:^{
                                   UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                   if ( ! [UIImagePickerController isSourceTypeAvailable:sourceType]) {
                                       [UIView showResultThenHide:@"您的设备无法通过此方式获取照片"];
                                       return;
                                   }
                                   else {
                                       if (singleImage) {//选择相册里单张图片
                                           UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                                           imagePickerController.delegate = delegate;
                                           imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                                           imagePickerController.allowsEditing = allowsEditing;
                                           imagePickerController.sourceType = sourceType;
                                           [viewController presentViewController:imagePickerController animated:YES completion:nil];
                                       }
                                       else {//多张图片
                                           ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
                                           picker.delegate = delegate;
                                           picker.maximumNumberOfSelection = numberOfSelection;
                                           picker.assetsFilter = [ALAssetsFilter allPhotos];
                                           picker.showEmptyGroups = NO;
                                           picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                                               if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
                                                   NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                                                   return duration >= 5;
                                               } else {
                                                   return YES;
                                               }
                                           }];
                                           [viewController presentViewController:picker animated:YES completion:NULL];
                                       }
                                   }
                               }];
    
    [actionSheet bk_setCancelButtonWithTitle:@"取消" handler:nil];
    [actionSheet showInView:viewController.view.window];
    return actionSheet;
}

#pragma mark - 添加手势
/**
 *	实现水平方向上左右滑动的动画效果
 *
 *	@param	view	需要做动画的view
 *	@param	subtype	方向 kCATransitionFromRight、kCATransitionFromLeft
 */
+ (void)animateHorizontalSwipe:(UIView *)view withSubType:(NSString *)subtype {
    ReturnWhenObjectIsEmpty(view);
    [view animateHorizontalSwipeWithSubType:subtype];
}
- (void)animateHorizontalSwipeWithSubType:(NSString *)subtype {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionPush;
    animation.subtype = subtype;
    [self.layer addAnimation:animation forKey:@"animation"];
}

//用于不是继承BaseViewController的时候用的
+ (MBProgressHUD *)showHUDLoading:(NSString *)hintString{
    UIView *view=[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud=[MBProgressHUD HUDForView:view];
    if (hud) {
        [hud show:YES];
    }else{
        hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.labelText=hintString;
    hud.mode=MBProgressHUDModeIndeterminate;
    return hud;
}
+ (void)hideHUDLoading{
    UIView *view=[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud=[MBProgressHUD HUDForView:view];
    [hud hide:YES];
}
+ (void)showResultThenHide:(NSString *)resultString {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.labelText = resultString;
    hud.mode = MBProgressHUDModeText;
    [hud show:YES];
    [hud hide:YES afterDelay:2];
}

#pragma mark alertView
+ (UIAlertView *)showAlertVieWithMessage:(NSString *)message{
    return [self showAlertViewWithTitle:nil andMessage:message];
}
+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message{
    UIAlertView *alertView=[UIAlertView bk_alertViewWithTitle:title message:message];
    [alertView bk_setCancelButtonWithTitle:@"确定" handler:NULL];
    [alertView show];
    return alertView;
}

#pragma mark - current view controller
+ (UIViewController *)currentViewController {
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIView getVisibleViewControllerFrom:viewController];
    return viewController;
}

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        return [UIView getVisibleViewControllerFrom:[((UINavigationController *) viewController) visibleViewController]];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        return [UIView getVisibleViewControllerFrom:[((UITabBarController *) viewController) selectedViewController]];
    } else {
        if (viewController.presentedViewController) {
            return [UIView getVisibleViewControllerFrom:viewController.presentedViewController];
        } else {
            return viewController;
        }
    }
}
@end
