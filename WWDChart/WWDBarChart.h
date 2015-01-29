//
//  WWDBarChart.h
//  WWDChart
//
//  Created by maginawin on 15-1-29.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWDChartDelegate.h"
#import "WWDBar.h"

#define xLabelMargin 15
#define yLabelMargin 15
#define yLabelHeight 11
#define xLabelHeight 20

typedef NSString * (^WWDYLabelFormatter) (CGFloat yLabelValue);

@interface WWDBarChart : UIView

- (void)strokeChart;

@property (nonatomic, strong) NSArray* xLabels;
@property (nonatomic, strong) NSArray* yLabels;
@property (nonatomic, strong) NSArray* yValues;

@property (nonatomic, strong) NSMutableArray* bars;

@property (nonatomic) CGFloat xLabelWidth;
@property (nonatomic) int yValueMax;
@property (nonatomic, strong) UIColor* strokeColor;
@property (nonatomic, strong) NSArray* strokeColors;

/** Update values. */
- (void)updateChartData:(NSArray*)data;

/** Changes chart margin. */
@property (nonatomic) CGFloat yChartLabelWidth;

/** Formats the yLabel text. */
@property (copy) WWDYLabelFormatter yLabelFormatter;

@property (nonatomic) CGFloat chartMargin;

/** Controls whether labels should be displayed. */
@property (nonatomic) BOOL showLabel;

/** Controls whether the chart border line should be displayed. */
@property (nonatomic) BOOL showChartBorder;

/** Chart bottom border, co-linear with the x-axis. */
@property (nonatomic, strong) CAShapeLayer* chartBottomLine;

/** Chart left border, co-linear with the y-axis. */
@property (nonatomic, strong) CAShapeLayer* chartLeftLine;

/** Corner radius for all bars in the chart. */
@property (nonatomic) CGFloat barRadius;

/** Width of all bars int the chart. */
@property (nonatomic) CGFloat barWidth;

@property (nonatomic) CGFloat labelMarginTop;

/** Background color of all bars in the chart. */
@property (nonatomic, strong) UIColor* barBackgroundColor;

/** Text color for all bars int the charts. */
@property (nonatomic, strong) UIColor* labelTextColor;

/** Font for all bars in the charts. */
@property (nonatomic, strong) UIFont* labelFont;

/** How many labels on the x-axis to skip in between displaying labels. */
@property (nonatomic) NSInteger xLabelSkip;

/** How many labels on the y-axis to skip in between displaying labels. */
@property (nonatomic) NSInteger yLabelSum;

/** The maximum for the range of values to display on the y-axis. */
@property (nonatomic) CGFloat yMaxValue;

/** The minimum for the range of values to display on the y-axis. */
@property (nonatomic) CGFloat yMinValue;

/** Controls whether each bar should have a gradient fill. */
@property (nonatomic, strong) UIColor* barColorGradientStart;

/** Controls whether text for x-axis be straight or rotate 45 degree. */
@property (nonatomic) BOOL rotateForXAxisText;

@property (nonatomic, weak) id<WWDChartDelegate> delegate;

@end
