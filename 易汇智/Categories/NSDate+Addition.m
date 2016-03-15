//
//  NSDate+Addition.m
//  GeneralFramework
//
//  Created by ZMJ on 15/5/14.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)
- (NSString *)timeScrp{
    return [NSString stringWithFormat:@"%.0f",[self timeIntervalSince1970]];
}

+ (NSArray *)currentDate{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger yearr = [dateComponent year];
    NSInteger monthr = [dateComponent month];
    NSInteger dayr = [dateComponent day];
    
    NSInteger year = yearr; //获取年份
    NSInteger month = monthr;//获取月份
    NSInteger day = dayr;//获取日期
    //判断当前月分的天数
    int endDate = 0;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            endDate = 31;
            break;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            endDate = 30;
            break;
        case 2:
            // 是否为闰年
            if (year % 400 == 0) {
                endDate = 29;
                break;
            } else {
                if (year % 100 != 0 && year %4 ==4) {
                    endDate = 29;
                } else {
                    endDate = 28;
                }
                break;
            }
            break;
        default:
            break;
    }
   return [self calculateDateWithEndDate:endDate withDay:day withMonth:month];
}

+(NSArray *)calculateDateWithEndDate:(int)endDate withDay:(NSInteger)day withMonth:(NSInteger)month{
    NSMutableArray *mutableArray=[NSMutableArray array];
    NSInteger tomorrow = 0; //明天
    NSInteger afterDay = 0;  //后天
    NSInteger tomorrowMonth = 0;
    NSInteger afterDayMonth = 0;
    
    if(endDate - day <= 0)
    {
        tomorrow = 1;
        afterDay = tomorrow + 1;
        tomorrowMonth = month + 1;
        if(tomorrowMonth > 12)
        {
            tomorrowMonth = 1;
        }
        afterDayMonth = tomorrowMonth;
    }
    
    else if(endDate - day == 1)
    {
        tomorrow = endDate;
        afterDay = 1;
        tomorrowMonth = month;
        afterDayMonth = month + 1;
        if(month == 12)
        {
            afterDayMonth = 1;
        }
    }
    
    else
    {
        tomorrow = day+1;
        afterDay = tomorrow + 1;
        tomorrowMonth = month;
        afterDayMonth = month;
    }
    //获取当前年份：2015
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger yearr = [dateComponent year];
    
    
    [mutableArray addObject:[NSString stringWithFormat:@"%zd-%zd-%zd",yearr,month,day]];
    [mutableArray addObject:[NSString stringWithFormat:@"%zd-%zd-%zd",yearr,tomorrowMonth,tomorrow]];
    [mutableArray addObject:[NSString stringWithFormat:@"%zd-%zd-%zd",yearr,afterDayMonth,afterDay]];
    
    return mutableArray;
    //NSLog(@"今天:%ld/%ld,明天:%ld/%ld,后天:%ld/%ld",month,day,tomorrowMonth,tomorrow,afterDayMonth,afterDay);
}

+ (NSString *)currentDataString:(NSString *)stringDate{
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter1 dateFromString:stringDate];
    
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    //用[NSDate date]可以获取系统当前时间
    return [dateFormatter stringFromDate:date];
}
/**
 * @brief 判断当前时间是否在fromHour和toHour之间。如，fromHour=8，toHour=23时，即为判断当前时间是否在8:00-23:00之间
 */
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *date8 = [self getCustomDateWithHour:fromHour];
    NSDate *date23 = [self getCustomDateWithHour:toHour];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date8]==NSOrderedDescending && [currentDate compare:date23]==NSOrderedAscending)
    {
        //NSLog(@"该时间在 %li:00-%li:00 之间！", fromHour, toHour);
        return YES;
    }
    return NO;
}
/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}


#pragma mark - bug
/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour minute:(NSInteger)minute
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    [resultComps setMinute:minute];
    
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}
/**
 * @brief 判断当前时间是否在fromHour和toHour之间。如，fromHour=8，toHour=23时，即为判断当前时间是否在8:00-23:00之间
 */
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour fromMinute:(NSInteger)fromMinute toHour:(NSInteger)toHour toMinute:(NSInteger)toMinute
{
    NSDate *date8 = [self getCustomDateWithHour:fromHour minute:fromMinute];
    NSDate *date23 = [self getCustomDateWithHour:toHour minute:toMinute];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date8]==NSOrderedDescending && [currentDate compare:date23]==NSOrderedAscending)
    {
        NSLog(@"该时间在 %li:00-%li:00 之间！", fromHour, toHour);
        return YES;
    }
    return NO;
}
@end
