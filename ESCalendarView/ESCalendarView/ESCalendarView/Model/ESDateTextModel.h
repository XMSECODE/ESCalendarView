//
//  DateTextModel.h
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/22.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ESDateTextModel : NSObject

/**
 文字颜色:default black
 */
@property(nonatomic,strong)UIColor* textColor;

/**
 是否隐藏圆圈 default YES
 */
@property(nonatomic,assign)BOOL hiddenCircle;
/**
 圆圈颜色 default green
 */
@property(nonatomic,strong)UIColor* circleColor;
/**
 圆圈的半径 default 20
 */
@property(nonatomic,assign)CGFloat circleRadius;

/**
 是否隐藏背景圆 default YES
 */
@property(nonatomic,assign)BOOL hiddenBackCircle;
/**
 背景颜色：圆 default yellow
 */
@property(nonatomic,strong)UIColor* backgroundColor;
/**
 背景圆的半径 default 20
 */
@property(nonatomic,assign)CGFloat backCircleRadius;

//被选的颜色 default green
@property(nonatomic,strong)UIColor* selectedColor;

/**
 default NO
 */
@property (nonatomic, assign) BOOL showPoint;

/**
 default red
 */
@property (nonatomic, strong) UIColor *pointColor;

/**
 default 1
 */
@property (nonatomic, assign) CGFloat pointRadius;

+ (instancetype)dateTextModelWithTextColor:(UIColor *)textColor
                              hiddenCircle:(BOOL)hiddenCircle
                               circleColor:(UIColor *)circleColor
                              circleRadius:(CGFloat)circleRadius
                          hiddenBackCircle:(BOOL)hiddenBackCircle
                           backgroundColor:(UIColor *)backgroundColor
                          backCircleRadius:(CGFloat)backCircleRadius;

@end
