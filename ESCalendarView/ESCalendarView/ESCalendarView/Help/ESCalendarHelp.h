//
//  CalendarHelp.h
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/21.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESCalendarHelp : NSObject


/**
 计算date所在月的总天数
 */
+ (NSInteger)getNumberOfDaysInMonth:(NSDate *)date;

/**
 计算date所在月的总星期数
 */
+ (NSUInteger)getNumberOfWeeksInMonth:(NSDate *)date;

/**
 计算指定日期在当月的多少号
 */
+ (NSUInteger)getDayNumberOfDate:(NSDate *)date;

/**
 返回指定日期的相隔offMonth个月的时间，返回的日期为指定月的15号
 */
+ (NSDate *)getDate:(NSDate *)date withOffMonth:(NSInteger)offMonth;

/**
 获取指定日期的当月的第一天的星期号 星期天== 1 星期一 == 2 ...星期六 == 7
 */
+ (NSInteger)getWeekDayOnThisMonthFirstDay:(NSDate *)date;

/**
 获取指定日期的当月的第一天时间
 */
+ (NSDate *)getFirstDayOnThisMonth:(NSDate *)date;

@end
