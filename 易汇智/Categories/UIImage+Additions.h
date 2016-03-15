//
//  UIImage+Additions.h
//  GeneralFramework
//
//  Created by ZMJ on 15/5/7.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)
//判断图片是否为透明
+ (BOOL)hasPrefx:(UIImage *)image;
//图片拉伸
+ (UIImage *)stretchableImag:(UIImage *)image withPoint:(CGPoint) point;
//调整图片的大小
+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size;
//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
