//
//  UITextField+Addition.m
//  GeneralFramework
//
//  Created by ZMJ on 15/4/19.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#import "UITextField+Addition.h"
#import <objc/runtime.h>

const char *ObjectTagKey;
@implementation UITextField (Addition)
- (void)setMaxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, ObjectTagKey, @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)maxLength {
    return [objc_getAssociatedObject(self, ObjectTagKey) integerValue];
}
@end
