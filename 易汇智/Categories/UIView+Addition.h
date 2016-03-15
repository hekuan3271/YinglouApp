//
//  UIView+Addition.h
//  GeneralFramework
//
//  Created by ZMJ on 15/4/19.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CTAssetsPickerController.h"
@interface UIView (Addition)

+ (void)makeCircleForImageView:(UIImageView *)imageView;
/**
 *  @param  allowsEditing 是否可以编辑
 *  @param  allowsImage 是否选择多张图片
 *  @param  allowsVideo 是否选择视频
 *  @param  numberOfSection 最大限制
 *  @param  viewsController 视图
 */
+ (UIActionSheet *)showImagePickerActionSheetDelegate:(id<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CTAssetsPickerControllerDelegate>)delegate
                                        allowsEditing:(BOOL)allowsEditing
                                          allowsImage:(BOOL)allowsImage
                                          allowsVideo:(BOOL)allowsVideo
                                      numberOfSection:(NSInteger)numberOfSection
                                         viewControls:(UIViewController *)viewsController;


+ (UIActionSheet *)showImagePickerActionSheetWithDelegate:(id<UINavigationControllerDelegate,
                                                           UIImagePickerControllerDelegate,
                                                           ZYQAssetPickerControllerDelegate>)delegate
                                            allowsEditing:(BOOL)allowsEditing
                                              singleImage:(BOOL)singleImage
                                        numberOfSelection:(NSInteger)numberOfSelection
                                         onViewController:(UIViewController *)viewController;

#pragma mark - 添加手势
/**
 *	实现水平方向上左右滑动的动画效果
 *
 *	@param	view	需要做动画的view
 *	@param	subtype	方向 kCATransitionFromRight、kCATransitionFromLeft
 */
+ (void)animateHorizontalSwipe:(UIView *)view withSubType:(NSString *)subtype;
- (void)animateHorizontalSwipeWithSubType:(NSString *)subtype;

/**
 *  如果不是继承BaseViewController的时候用的
 */
#pragma mark show&hide
+ (MBProgressHUD *)showHUDLoading:(NSString *)hintString;
+ (void)hideHUDLoading;
+ (void)showResultThenHide:(NSString *)resultString;

#pragma mark alertView
+ (UIAlertView *)showAlertVieWithMessage:(NSString *)message;
+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message;

#pragma mark - current view controller
+ (UIViewController *)currentViewController;
+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)viewController;

@end
