//
//  MonthView.h
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/21.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESDateView.h"
#import "ESCalendarSetting.h"

@interface ESMonthView : UIView

@property(nonatomic,strong)ESCalendarSetting* calendarSetting;

@property(nonatomic,strong)NSDate* date;

@property(nonatomic,copy)void(^prepareDraw)(NSDate* date,ESDateTextModel* dateTextModel);

@property(nonatomic,copy)void(^didTouchDate)(NSDate* date,ESDateTextModel* dateTextModel);

- (void)reloadView;

@end
