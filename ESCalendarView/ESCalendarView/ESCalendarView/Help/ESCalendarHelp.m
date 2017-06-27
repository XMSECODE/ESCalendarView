//
//  CalendarHelp.m
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/21.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import "ESCalendarHelp.h"

@interface ESCalendarHelp ()

@property(nonatomic,strong)NSCalendar* calendar;

@property(nonatomic,strong)NSDateFormatter* dDateFormatter;

@property(nonatomic,strong)NSDateFormatter* yyyyDateFormatter;

@property(nonatomic,strong)NSDateFormatter* MMDateFormatter;

@property(nonatomic,strong)NSDateFormatter* yyyyMMDateFormatter;

@property(nonatomic,strong)NSDateFormatter* eDateFormatter;

@end

static ESCalendarHelp* staticCalendarHelp;

@implementation ESCalendarHelp

+ (instancetype)sharedCalendarHelp {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticCalendarHelp = [[ESCalendarHelp alloc] init];
        staticCalendarHelp.calendar = [NSCalendar currentCalendar];
    });
    return staticCalendarHelp;
}

+ (NSInteger)getNumberOfDaysInMonth:(NSDate *)date {
    NSRange range = [[ESCalendarHelp sharedCalendarHelp].calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

+ (NSUInteger)getNumberOfWeeksInMonth:(NSDate *)date {
    NSRange range = [[ESCalendarHelp sharedCalendarHelp].calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

+ (NSUInteger)getDayNumberOfDate:(NSDate *)date {
    NSString* dayString = [[ESCalendarHelp sharedCalendarHelp].dDateFormatter stringFromDate:date];
    return [dayString integerValue];
}

+ (NSDate *)getDate:(NSDate *)date withOffMonth:(NSInteger)offMonth {
    
    NSInteger year = [[[ESCalendarHelp sharedCalendarHelp].yyyyDateFormatter stringFromDate:date] integerValue];
    NSInteger month = [[[ESCalendarHelp sharedCalendarHelp].MMDateFormatter stringFromDate:date] integerValue];
    year = year + (NSUInteger)(offMonth / 12);
    month = month + offMonth % 12;
    if (month > 12) {
        month = month - 12;
        year++;
        offMonth = 0;
    }else if (month <= 0) {
        month = 12 - month;
        year--;
        offMonth = 0;
    }
    NSString* dateString = [NSString stringWithFormat:@"%zd-%zd-15",year,month];
    NSDate* resultDate = [[ESCalendarHelp sharedCalendarHelp].yyyyMMDateFormatter dateFromString:dateString];
    return resultDate;
}

+ (NSInteger)getWeekDayOnThisMonthFirstDay:(NSDate *)date {
    
    NSDateComponents *componentsCurrentDate = [[ESCalendarHelp sharedCalendarHelp].calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = 1;
    componentsNewDate.day = 1;
    
    NSDate* firstDate = [[ESCalendarHelp sharedCalendarHelp].calendar dateFromComponents:componentsNewDate];
    
    
    NSString* str = [[ESCalendarHelp sharedCalendarHelp].eDateFormatter stringFromDate:firstDate];
    return [str integerValue];
}

+ (NSDate *)getFirstDayOnThisMonth:(NSDate *)date {
    NSDateComponents *componentsCurrentDate = [[ESCalendarHelp sharedCalendarHelp].calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = 1;
    componentsNewDate.day = 1;
    
    return [[ESCalendarHelp sharedCalendarHelp].calendar dateFromComponents:componentsNewDate];
}

#pragma mark - setter & getter
- (NSDateFormatter *)dDateFormatter {
    if (_dDateFormatter == nil) {
        _dDateFormatter = [[NSDateFormatter alloc] init];
        _dDateFormatter.dateFormat = @"d";
    }
    return _dDateFormatter;
}

- (NSDateFormatter *)yyyyDateFormatter {
    if (_yyyyDateFormatter == nil) {
        _yyyyDateFormatter = [[NSDateFormatter alloc] init];
        _yyyyDateFormatter.dateFormat = @"yyyy";
    }
    return _yyyyDateFormatter;
}

- (NSDateFormatter *)MMDateFormatter {
    if (_MMDateFormatter == nil) {
        _MMDateFormatter = [[NSDateFormatter alloc] init];
        _MMDateFormatter.dateFormat = @"MM";
    }
    return _MMDateFormatter;
}

- (NSDateFormatter *)yyyyMMDateFormatter {
    if (_yyyyMMDateFormatter == nil) {
        _yyyyMMDateFormatter = [[NSDateFormatter alloc] init];
        _yyyyMMDateFormatter.dateFormat = @"yyyy-MM-d";
    }
    return _yyyyMMDateFormatter;
}

- (NSDateFormatter *)eDateFormatter {
    if (_eDateFormatter == nil) {
        _eDateFormatter = [[NSDateFormatter alloc] init];
        _eDateFormatter.dateFormat = @"e";
    }
    return _eDateFormatter;
}

@end
