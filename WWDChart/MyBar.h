//
//  MyBar.h
//  WWDChart
//
//  Created by maginawin on 15-1-29.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BAR_CORNER_RADIUS 2.0f

@interface MyBar : UIView

@property (nonatomic) CGFloat barValue;

/** 初始化 */
- (id)initWithFrame:(CGRect)frame andStrokeColor:(UIColor*)strokeColor bgColor:(UIColor*)bgColor barWidth:(CGFloat)barWidth;

/** 0.0 ~ 1.0 之间的任意 CGFloat */
- (void)updateBarValue:(CGFloat)value;

@end
