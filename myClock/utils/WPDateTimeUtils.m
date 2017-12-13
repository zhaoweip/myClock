//
//  WPDateTimeUtils.m
//  myClock
//
//  Created by Macintosh on 13/12/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import "WPDateTimeUtils.h"

@implementation WPDateTimeUtils

#pragma mark - 根据传入日期格式获得相应时间
+ (NSString *)getCurrentTimeWithFormatter:(NSString *)formatterStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

#pragma mark - 获取某年某月的天数
+ (NSInteger)getDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

#pragma mark - 根据星期的英文简写获得中文
+ (NSString*)getChineseWeekFromEng:(NSString *)week{
    if ([week isEqualToString:@"Mon"]) {
        return @"周一";
    }else if([week isEqualToString:@"Tue"]){
        return @"周二";
    }else if([week isEqualToString:@"Wed"]){
        return @"周三";
    }else if([week isEqualToString:@"Thu"]){
        return @"周四";
    }else if([week isEqualToString:@"Fri"]){
        return @"周五";
    }else if([week isEqualToString:@"Sat"]){
        return @"周六";
    }else if([week isEqualToString:@"Sun"]){
        return @"周日";
    }else{
        return week;
    }
}

#pragma mark - 根据小时获得相应时辰
+ (NSString *)getShiChenStringFromHour:(NSString *)hour{
    NSArray *shiChenArray = [[NSArray alloc] initWithObjects:@"子时",@"丑时",@"寅时",@"卯时",@"辰时",@"巳时",@"午时",@"未时",@"申时",@"酉时",@"戌时",@"亥时", nil];
    int hourInt = [hour intValue];
    if (hourInt == 0 || hourInt == 23) {
        return @"子时";
    }else{
        return [shiChenArray objectAtIndex:(hourInt + 1)/2];
    }
}

#pragma mark - 获取指定日期的星期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays =[NSArray arrayWithObjects:[NSNull null], @"周日", @"周一", @"周二", @"周三",@"周四", @"周五", @"周六",nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}
#pragma mark - 获取两个时间的时间差（秒数）
+ (NSTimeInterval)getTimeIntervalFrom:(NSString *)startTime to:(NSString *)endTime
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSDate * startDate = [dateFormatter dateFromString:startTime];
    NSDate * endDate   = [dateFormatter dateFromString:endTime];
    
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    return time;
}

@end
