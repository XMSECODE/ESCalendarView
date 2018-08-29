//
//  ESMultiSelectDateCalendarView.h
//  ESCalendarView
//
//  Created by xiang on 2018/8/28.
//  Copyright © 2018年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ESMultiSelectDateCalendarView;

@protocol ESMultiSelectDateCalendarViewDelegate <NSObject>

- (void)ESMultiSelectDateCalendarView:(ESMultiSelectDateCalendarView *)calendarView selectedStartDate:(NSDate *)startDate selectedEndDate:(NSDate *)endDate;

@end

@interface ESMultiSelectDateCalendarView : UIView

@property(nonatomic,strong)UIColor* selectedBackgroundColor;

@property(nonatomic,strong)UIColor* selectedTextColor;

@property(nonatomic,weak)id<ESMultiSelectDateCalendarViewDelegate> delegate;

@end
