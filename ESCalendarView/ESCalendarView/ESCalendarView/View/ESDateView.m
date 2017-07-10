//
//  DateView.m
//  XLBCalendarViewDemo
//
//  Created by xiang on 2017/2/22.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import "ESDateView.h"
#import "ESCalendarHelp.h"

static NSString* DidSelectedDateViewNotificationKey = @"didSelectedDateViewNotificationKey";

@interface ESDateView ()

@property(nonatomic,strong)NSArray<ESDateTextModel *>* modelArray;

@property(nonatomic,weak)CAShapeLayer* shapeLayer;

/**
 被点击的日期的下标
 */
@property(nonatomic,assign)NSUInteger didTouchDateIndex;

@property(nonatomic,assign)CGSize daySize;

@end


@implementation ESDateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiverDidSelectedDateViewNotification:) name:DidSelectedDateViewNotificationKey object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiverDidSelectedDateViewNotification:(NSNotification *)notification {
    if (notification.object != self) {
        self.didTouchDateIndex = 0;
        [self.shapeLayer removeFromSuperlayer];
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSInteger dayCount = [ESCalendarHelp getNumberOfDaysInMonth:self.date];
    NSInteger weekCount = [ESCalendarHelp getNumberOfWeeksInMonth:self.date];
    
    CGFloat width = rect.size.width / 7;
    CGFloat height = rect.size.height / weekCount;
    self.daySize = CGSizeMake(width, height);
    NSInteger startIndex = [ESCalendarHelp getWeekDayOnThisMonthFirstDay:self.date] - 1;
    
    NSDate* startDate = [ESCalendarHelp getFirstDayOnThisMonth:self.date];
    if (self.prepareDraw != nil) {
        for (int i = 0; i < dayCount; i++) {
            self.prepareDraw([NSDate dateWithTimeInterval:3600 * 24 * i sinceDate:startDate],self.modelArray[i]);
        }
    }
    for (int i = 0; i < dayCount; i++) {
        CGFloat x = ((startIndex + i) % 7 )* width;
        CGFloat y = (startIndex + i) / 7 * height;
        ESDateTextModel* model = self.modelArray[i];
        

        
        if (self.didTouchDateIndex == i + 1) {
            
        }else {
            if (model.hiddenCircle == NO) {
                CGContextSetStrokeColorWithColor(context, model.circleColor.CGColor);
                CGContextSetLineWidth(context, 1.0);//线的宽度
                CGContextAddArc(context, x + width / 2, y + height / 2, model.circleRadius - 0.5, 2 * M_PI, 0, 1);
                CGContextDrawPath(context, kCGPathStroke); //绘制路径
            }
            
            if (model.hiddenBackCircle == NO) {
                CGContextSetFillColorWithColor(context, model.backgroundColor.CGColor);
                CGContextAddArc(context, x + width / 2, y + height / 2, model.backCircleRadius, 0, 2 * M_PI, 0); //添加一个圆
                CGContextDrawPath(context, kCGPathFill);//绘制填充
            }
            if (model.showPoint == YES) {
                CGContextSetFillColorWithColor(context, model.pointColor.CGColor);
                CGContextAddArc(context, x + width / 2, y + height - model.pointRadius - 2, model.pointRadius, 0, 2 * M_PI, 0); //添加一个圆
                CGContextDrawPath(context, kCGPathFill);//绘制填充
            }

            [self drawText:[NSString stringWithFormat:@"%02d",i + 1] frame:CGRectMake(x, y, width, height) dateTextModel:model textSize:self.textSize];
        }
        
    }
}

- (void)drawText:(NSString *)text frame:(CGRect)frame dateTextModel:(ESDateTextModel *)dateTextModel textSize:(CGFloat)textSize{
    NSDictionary* attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:textSize],
                                 NSForegroundColorAttributeName:dateTextModel.textColor
                                 };
    CGSize size = [text sizeWithAttributes:attributes];
    CGRect drawRect = CGRectMake((frame.size.width - size.width) / 2 + frame.origin.x, (frame.size.height - size.height) / 2 + frame.origin.y, size.width, size.height);
    
    [text drawInRect:drawRect withAttributes:attributes];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DidSelectedDateViewNotificationKey object:self];
    //根据坐标计算日期
    NSInteger weekCount = [ESCalendarHelp getNumberOfWeeksInMonth:self.date];
    NSInteger startIndex = [ESCalendarHelp getWeekDayOnThisMonthFirstDay:self.date] - 1;
    CGFloat width = self.bounds.size.width / 7;
    CGFloat height = self.bounds.size.height / weekCount;
    NSInteger dayCount = [ESCalendarHelp getNumberOfDaysInMonth:self.date];
    
    int row = (int)(touchPoint.x / width);
    int rol = (int)(touchPoint.y / height);
    NSInteger dateCount = rol * 7 + row - startIndex + 1;
    NSDate* startDate = [ESCalendarHelp getFirstDayOnThisMonth:self.date];
    startDate = [startDate initWithTimeInterval:- 15 * 3600 sinceDate:startDate];
    if (dateCount <= 0 || dateCount > dayCount) {
        return;
    }
    
    if (self.didTouchDate != nil) {
        self.didTouchDate([NSDate dateWithTimeInterval:24 * 3600 * dateCount sinceDate:startDate],self.modelArray[dateCount - 1]);
    }
    
    self.didTouchDateIndex = dateCount;
    // animation
    CGFloat x = ((startIndex + dateCount - 1) % 7 )* width;
    CGFloat y = (startIndex + dateCount - 1) / 7 * height;
    
    ESDateTextModel* model = self.modelArray[self.didTouchDateIndex - 1];
    [self createShapeLayerWithCenter:CGRectMake(x + width / 2 - model.backCircleRadius, y + height / 2 - model.backCircleRadius, model.backCircleRadius * 2, model.backCircleRadius * 2 + 2)];
    
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.fromValue = @(0);
        animation.toValue = @(1);
        animation.removedOnCompletion = NO;
        animation.duration = self.animationDuration;
    
    
    UIImage* image = [self creatImageWithText:[NSString stringWithFormat:@"%02zd",dateCount] backColor:model.selectedColor dateTextModel:model];
    self.shapeLayer.contents = (__bridge id _Nullable)(image.CGImage);
    
    [self.shapeLayer addAnimation:animation forKey:@"calendarAnimation"];

    [self setNeedsDisplay];
    
}

- (UIImage *)creatImageWithText:(NSString *)text backColor:(UIColor *)backColor dateTextModel:(ESDateTextModel *)dateTextModel {
    CGFloat size = MIN(dateTextModel.backCircleRadius * 2, dateTextModel.backCircleRadius * 2);
    
    UIGraphicsBeginImageContext(CGSizeMake(size * 2, size * 2 + 4));
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    
    
    CGFloat arcX = size;
    CGFloat arcY = size;
    CGFloat arcRadius = size;
    CGContextSetFillColorWithColor(context, backColor.CGColor);
    CGContextAddArc(context, arcX , arcY, arcRadius, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    CGFloat textX = 0;
    CGFloat textY = 0;
    CGFloat textW = size * 2;
    CGFloat textH = size * 2;
    [self drawText:text frame:CGRectMake(textX, textY, textW, textH) dateTextModel:dateTextModel textSize:self.textSize * 2];
    
    if (dateTextModel.showPoint) {
        CGContextSetFillColorWithColor(context, dateTextModel.pointColor.CGColor);
        CGContextAddArc(context, size, size * 2, 4, 0, 2 * M_PI, 0);
        CGContextDrawPath(context, kCGPathFill);
    }

    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return newImage;
    
}

- (void)reloadView {
    [self.shapeLayer removeFromSuperlayer];
    self.didTouchDateIndex = 0;
    [self setNeedsDisplay];
}

- (NSArray<ESDateTextModel *> *)modelArray {
    if (_modelArray == nil) {
        NSInteger weekCount = [ESCalendarHelp getNumberOfDaysInMonth:self.date];
        NSMutableArray* temArray = [NSMutableArray array];
        for (int i = 0; i < weekCount; i++) {
            ESDateTextModel* model = [[ESDateTextModel alloc] init];
            [temArray addObject:model];
        }
        _modelArray = temArray;
    }
    return _modelArray;
}

- (CAShapeLayer *)createShapeLayerWithCenter:(CGRect)frame {
    if (self.shapeLayer) {
        [self.shapeLayer removeFromSuperlayer];
    }
    CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer = shapeLayer;
    [self.layer addSublayer:shapeLayer];
    self.shapeLayer.frame = frame;
    return self.shapeLayer;
}

@end
