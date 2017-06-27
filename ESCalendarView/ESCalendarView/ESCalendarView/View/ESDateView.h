//
//  DateView.h
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/22.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESDateTextModel.h"
#import "ESCalendarSetting.h"

@interface ESDateView : UIView

@property(nonatomic,strong)NSDate* date;

@property(nonatomic,assign)CGFloat textSize;

@property(nonatomic,assign)CGFloat animationDuration;

@property(nonatomic,copy)void(^prepareDraw)(NSDate* date,ESDateTextModel* dateTextModel);

@property(nonatomic,copy)void(^didTouchDate)(NSDate* date,ESDateTextModel* dateTextModel);

- (void)reloadView;

@end
