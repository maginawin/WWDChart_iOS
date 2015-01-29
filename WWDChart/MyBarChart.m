//
//  MyBarChart.m
//  WWDChart
//
//  Created by maginawin on 15-1-29.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import "MyBarChart.h"

#define XY_LINE_WIDTH 1.0 // x y 轴线宽
#define BOTTOM_MARGIN 20.0 // x 距下间隔
#define LEFT_MARGIN 40.0 // y 距左间隔
#define TOP_MARGIN 8.0 // y 距上间隔
#define RIGHT_MARGIN 8.0 // x 距右间隔
#define MY_WIDTH (self.bounds.size.width) // 本视图宽
#define MY_HEIGHT (self.bounds.size.height) // 本视图高

@interface MyBarChart()

@property (nonatomic) CGFloat barWidth;
@property (nonatomic) CGFloat barHeight;

@property (nonatomic) NSInteger counts;
@property (nonatomic, strong) UIColor* xyColor;
@property (nonatomic, strong) UIColor* labelColor;
@property (nonatomic, strong) UIColor* barColor;
@property (nonatomic, strong) UIColor* barBgColor;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@end

@implementation MyBarChart

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _width = MY_WIDTH - LEFT_MARGIN - RIGHT_MARGIN;
    _height = MY_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN;
}

- (void)setupCounts:(NSInteger)counts xyAxisColor:(UIColor*)xyColor labelColor:(UIColor*)labelColor barColor:(UIColor*)barColor barBgColor:(UIColor*)barBgColor {
    _counts = counts;
    _myBars = [NSMutableArray array];
    _xyColor = xyColor;
    _labelColor = labelColor;
    _barColor = barColor;
    _barBgColor = barBgColor;
    [self strokeXYAxisLine];
    
    _barWidth = _width / counts;
    _barHeight = _height;
    
    for (int i = 0; i < counts; i++) {
        [self addBar:0.0 atIndex:i withXName:@""];
    }
}

- (void)addBar:(CGFloat)value atIndex:(NSInteger)index withXName:(NSString*)xName{
    if (index > _counts - 1) {
        return;
    }
    MyBar* myBar = [[MyBar alloc] initWithFrame:CGRectMake([self getMyBarXPositionAtIndex:index], TOP_MARGIN, _barWidth, _barHeight) andStrokeColor:_barColor bgColor:_barBgColor barWidth:_barWidth / 2];
    [_myBars addObject:myBar];
    [self.layer addSublayer:myBar.layer];
}

- (CGFloat)getMyBarXPositionAtIndex:(NSInteger)index {
    return index * _barWidth + LEFT_MARGIN;
}

- (void)strokeXYAxisLine {
    CALayer* yLayer = [CALayer layer];
    yLayer.backgroundColor = _xyColor.CGColor;
    yLayer.frame = CGRectMake(LEFT_MARGIN - XY_LINE_WIDTH, TOP_MARGIN, XY_LINE_WIDTH, MY_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN);
    CALayer* xLayer = [CALayer layer];
    xLayer.backgroundColor = _xyColor.CGColor;
    xLayer.frame = CGRectMake(LEFT_MARGIN - XY_LINE_WIDTH, MY_HEIGHT - BOTTOM_MARGIN, MY_WIDTH - LEFT_MARGIN - RIGHT_MARGIN, XY_LINE_WIDTH);
    
    [self.layer addSublayer:yLayer];
    [self.layer addSublayer:xLayer];
}

@end
