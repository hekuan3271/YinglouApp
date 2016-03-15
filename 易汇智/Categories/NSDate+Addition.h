//
//  NSDate+Addition.h
//  GeneralFramework
//
//  Created by ZMJ on 15/5/14.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)
- (NSString *)timeScrp;

/**
 *  获取三天时间日期
 */
+ (NSArray *)currentDate;
//讲时间转换成时间戳
+ (NSString *)currentDataString:(NSString *)stringDate;

/**
 *  判断时间是否在某个时间段类
 */
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour;

+ (BOOL)isBetweenFromHour:(NSInteger)fromHour fromMinute:(NSInteger)fromMinute toHour:(NSInteger)toHour toMinute:(NSInteger)toMinute;
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour minute:(NSInteger)minute;
@end
