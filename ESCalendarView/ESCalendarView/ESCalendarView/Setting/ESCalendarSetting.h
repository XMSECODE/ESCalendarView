//
//  CalendarSetting.h
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/21.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ESDateTextModel.h"

typedef enum : NSUInteger {
    LastMonth = 1,
    ThisMonth = 2,
    NextMonth = 3
} MonthType;

@interface ESCalendarSetting : NSObject

//default black
@property(nonatomic,strong)UIColor* weekViewTextColor;
//default black 可以特别为周末设置颜色
@property(nonatomic,strong)UIColor* weekViewWeekendTextColor;
//default 20
@property(nonatomic,assign)CGFloat weekViewTextSize;

//startDate 和 monthType 中设置一个即可，若设置了startDate则monthType无效,若两个都没有设置，则monthType为LastMonth.startDate只有年和月有影响
@property(nonatomic,strong)NSDate* startDate;
//default is ThisMonth
@property(nonatomic,assign)MonthType monthType;
//计算好的date数组
@property(nonatomic,strong,readonly)NSArray<NSDate *>* dateArray;

//default is 1 需要绘制的月的数量
@property(nonatomic,assign)NSUInteger calendarMonths;
//default is 0 开始展示的日历的月的下标
@property(nonatomic,assign)NSUInteger startMonthsIndex;
//default 20
@property(nonatomic,assign)CGFloat dateViewTextSize;
//被点击的动画时间
@property(nonatomic,assign)CGFloat animationDuration;

@end
