//
//  NSObject+Addition.h
//  xcode6
//
//  Created by ZMJ on 15/3/12.
//  Copyright (c) 2015年 MJShareDemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Addition)
+ (BOOL)isEmpty:(id)object;
+ (BOOL)isNotEmpty:(id)object;
+ (NSString *)MD5Encrypt:(NSString *)string;//md5
- (NSString *)getSha1String:(NSString *)srcString;//sha1
@end
