//
//  UILabel+Additions.m
//  GeneralFramework
//
//  Created by ZMJ on 15/5/14.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#import "UILabel+Additions.h"

@implementation UILabel (Additions)
- (void)horseRaceLampWithLabel:(UILabel *)label{
    [label sizeToFit];
    CGRect frame = label.frame;
    frame.origin.x = 320;
    label.frame = frame;
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:28.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    
    frame = label.frame;
    frame.origin.x = -frame.size.width;
    label.frame = frame;
    [UIView commitAnimations];
}
@end
