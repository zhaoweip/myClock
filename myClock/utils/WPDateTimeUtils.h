//
//  WPDateTimeUtils.h
//  myClock
//
//  Created by Macintosh on 13/12/17.
//  Copyright © 2017年 Macintosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPDateTimeUtils : NSObject

/*
 *根据传入日期格式获得相应时间，如：[WPDateTimeUtils getCurrentTimeWithFormatter:@"YYYY"],获得2017；
 */
+ (NSString *)getCurrentTimeWithFormatter:(NSString *)formatterStr;

/*
 *获取某年某月的天数
 */
+ (NSInteger)getDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month;

/*
 *根据星期的英文简写获得中文，如：[WPDateTimeUtils getChineseWeekFromEng:@"Wed"],获得周三；
 */
+ (NSString *)getChineseWeekFromEng:(NSString *)week;

/*
 *根据小时获得相应时辰，如：[WPDateTimeUtils getShiChenStringFromHour:@"23"],获得子时；
 */
+ (NSString *)getShiChenStringFromHour:(NSString *)hour;

/*
 *获取指定日期的星期，注意传入格式要为NSDate；
 */
+ (NSString *)weekdayStringFromDate:(NSDate*)inputDate;

@end
