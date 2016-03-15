//
//  UIImage+Additions.m
//  GeneralFramework
//
//  Created by ZMJ on 15/5/7.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#import "UIImage+Additions.h"
#import <UIImage+Resize.h>
@implementation UIImage (Additions)
//图片是否为透明
+ (BOOL)hasPrefx:(UIImage *)image{
    ReturnNOWhenObjectIsEmpty(image);
    return [image hasAlpha ];
}
- (BOOL)hasAlpha{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}
//图片拉伸
+ (UIImage *)stretchableImag:(UIImage *)image withPoint:(CGPoint)point{
    return [self stretchImage:image withEdgeInset:UIEdgeInsetsMake(point.y, point.x, point.y, point.x)];
}
+ (UIImage *)stretchImage:(UIImage *)image withEdgeInset:(UIEdgeInsets)edgeInset {
    ReturnNilWhenObjectIsEmpty(image)
    return [image resizableImageWithCapInsets:edgeInset resizingMode:UIImageResizingModeStretch];
}

//调整图片大小
+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size {
    return [self resizeImage:image toSize:size scale:NO];
}
+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size scale:(BOOL)scale {
    ReturnNilWhenObjectIsEmpty(image)
    return [image resizedImageToFitInSize:size scaleIfSmaller:scale];
}

//图片压缩
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    ReturnNilWhenObjectIsEmpty(image);
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}
@end
