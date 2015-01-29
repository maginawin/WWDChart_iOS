//
//  WWDCircleChart.h
//  WWDChart
//
//  Created by maginawin on 15-1-28.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import <UIKit/UIKit.h>
// 定义枚举来制定 chart format type
typedef NS_ENUM(NSInteger, WWDChartFormatType) {
    WWDChartFormatTypePercent = 1,
    WWDChartFormatTypeDollar,
    WWDChartFormatTypeNone
};

// degrees 角度, 度数 radians 弧度  将角度 angle 转为弧度的 define
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface WWDCircleChart : UIView

/**
 * 初始化 chart
 */
- (void)strokeChart;

/**
 *
 */
- (void)growChartByAmount:(NSNumber*)growAmount;

/**
 *
 */
- (void)updateChartByCurrent:(NSNumber*)current;

/**
 * 初始化 
 * total: 最大值 
 * current: 目前值
 * clockwise: 顺时针 (YES)
 * shadow: 阴影 (YES)
 */
- (id)initWithFrame:(CGRect)frame total:(NSNumber*)total current:(NSNumber*)current clockwise:(BOOL)clockwise shadow:(BOOL)hasBackgroundShadow;

@property (strong, nonatomic) UILabel* countingLabel;
@property (nonatomic) UIColor* strokeColor;
@property (nonatomic) UIColor* strokeColorGradientStart;
@property (nonatomic) NSNumber* total;
@property (nonatomic) NSNumber* current;
@property (nonatomic) NSNumber* lineWidth;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) WWDChartFormatType chartType;

@property (nonatomic) CAShapeLayer* circle;
@property (nonatomic) CAShapeLayer* gradientMask; // mask 掩饰; gradient 梯度
@property (nonatomic) CAShapeLayer* circleBackground;

@end
