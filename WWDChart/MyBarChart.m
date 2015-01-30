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
#define LEFT_MARGIN 44.0 // y 距左间隔
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

#pragma mark - Init

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
    _myXLabels = [NSMutableArray array];
    _myBars = [NSMutableArray array];
}

- (void)setupCounts:(NSInteger)counts xyAxisColor:(UIColor*)xyColor yArray:(NSArray*)yArray labelColor:(UIColor*)labelColor barColor:(UIColor*)barColor barBgColor:(UIColor*)barBgColor barGrade:(BOOL)grade gradeColor:(UIColor *)gradeColor {
    _counts = counts;
    _xyColor = xyColor;
    _labelColor = labelColor;
    _barColor = barColor;
    _barBgColor = barBgColor;
    [self strokeXYAxisLine];
    
    _barWidth = _width / counts;
    _barHeight = _height;
    
    [self addYAxis:yArray];
    
    for (int i = 0; i < counts; i++) {
        [self addBar:0.0 atIndex:i withXName:[NSString stringWithFormat:@"%d", i] withGrade:grade gradeColor:gradeColor];
    }
}

#pragma mark - Stroke

/** 添加 MyBar 和 MyBar 下的 xLabel */
- (void)addBar:(CGFloat)value atIndex:(NSInteger)index withXName:(NSString*)xName withGrade:(BOOL)grade gradeColor:(UIColor*)gradeColor {
    if (index > _counts - 1) {
        return;
    }
    MyBar* myBar = [[MyBar alloc] initWithFrame:CGRectMake(index * _barWidth + LEFT_MARGIN, TOP_MARGIN, _barWidth, _barHeight) andStrokeColor:_barColor bgColor:_barBgColor barWidth:_barWidth / 2 withGrade:grade theColor:gradeColor];
    UILabel* xLabel = [[UILabel alloc] initWithFrame:CGRectMake(index * _barWidth + LEFT_MARGIN, MY_HEIGHT - BOTTOM_MARGIN, _barWidth, BOTTOM_MARGIN)];
    xLabel.textAlignment = NSTextAlignmentCenter;
    xLabel.textColor = _labelColor;
    xLabel.text = xName;
    xLabel.font = [UIFont systemFontOfSize:13.0f];
    [_myBars addObject:myBar];
    [_myXLabels addObject:xLabel];
    [self addSubview:xLabel];
    [self addSubview:myBar];
}

- (void)addYAxis:(NSArray*)yArray {
    if (yArray.count > 0) {
        CGFloat perHeith = 0.0f;
        if (yArray.count > 1) {
            perHeith = (MY_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN) / (yArray.count - 1);
        }
        for (int i = 0; i < yArray.count; i++) {
            UILabel* yLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (MY_HEIGHT - BOTTOM_MARGIN - (i * perHeith) - 11.0), LEFT_MARGIN - 4.0, 22.0)];
            yLabel.textAlignment = NSTextAlignmentRight;
            yLabel.textColor = _labelColor;
            yLabel.font = [UIFont systemFontOfSize:13.0f];
            yLabel.text = [yArray objectAtIndex:i];
            [self addSubview:yLabel];
            [_myYLables addObject:yLabel];
            NSLog(@"y");
        }
    }
}

- (void)strokeXYAxisLine {
    CALayer* yLayer = [CALayer layer];
    yLayer.backgroundColor = _xyColor.CGColor;
    yLayer.frame = CGRectMake(LEFT_MARGIN - XY_LINE_WIDTH, 0.0, XY_LINE_WIDTH, MY_HEIGHT - BOTTOM_MARGIN);
    CALayer* xLayer = [CALayer layer];
    xLayer.backgroundColor = _xyColor.CGColor;
    xLayer.frame = CGRectMake(LEFT_MARGIN - XY_LINE_WIDTH, MY_HEIGHT - BOTTOM_MARGIN, MY_WIDTH - LEFT_MARGIN - RIGHT_MARGIN, XY_LINE_WIDTH);
    
    [self.layer addSublayer:yLayer];
    [self.layer addSublayer:xLayer];
}

@end
