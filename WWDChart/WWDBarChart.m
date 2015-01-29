//
//  WWDBarChart.m
//  WWDChart
//
//  Created by maginawin on 15-1-29.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import "WWDBarChart.h"

@interface WWDBarChart() {
    NSMutableArray* _xChartLabels;
    NSMutableArray* _yChartLabels;
}

- (UIColor*)barColorAtIndex:(NSUInteger)index;

@end

@implementation WWDBarChart

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setupDefaultValues {
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.showLabel = YES;
    self.barBackgroundColor = [UIColor lightGrayColor];
    self.labelTextColor = [UIColor grayColor];
    self.labelFont = [UIFont systemFontOfSize:11.0f];
    _xChartLabels = [NSMutableArray array];
    _yChartLabels = [NSMutableArray array];
    _bars = [NSMutableArray array];
    self.xLabelSkip = 1;
    self.yLabelSum = 4;
    self.labelMarginTop = 0;
    self.chartMargin = 15.0;
    self.barRadius = 2.0;
    self.showChartBorder = NO;
    self.yChartLabelWidth = 18;
    self.rotateForXAxisText = false;
}

- (void)setValues:(NSArray*)yValues {
    _yValues = yValues;
    if (_yMaxValue) {
        _yValueMax = _yMaxValue;
    } else {
        [self getYValueMax:yValues];
    }
    if (_yChartLabels) {
        [self viewCleanupForCollection:_yChartLabels];
    } else {
        _yChartLabels = [NSMutableArray array];
    }
    
    if (_showLabel) {
        // Add y labels
        float yLabelSectionHeight = (self.frame.size.height - _chartMargin * 2 - xLabelHeight) / _yLabelSum;
        for (int index = 0; index < _yLabelSum; index++) {
            NSString* labelText = _yLabelFormatter((float)_yValueMax * ((_yLabelSum - index) / (float)_yLabelSum));
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, yLabelSectionHeight * index + _chartMargin - yLabelHeight / 2.0, _yChartLabelWidth, yLabelHeight)];
            label.font = _labelFont;
            label.textColor = _labelTextColor;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = labelText;
            
            [_yChartLabels addObject:label];
            [self addSubview:label];
        }
    }
}

- (void)getYValueMax:(NSArray*)yLabels {
    int max = [[yLabels valueForKey:@"@max.intValue"] intValue];
    _yValueMax = (int)max;
    if (_yValueMax == 0) {
        _yValueMax = _yMinValue;
    }
}

- (void)viewCleanupForCollection:(NSArray*)yChartLabels {
    
}

- (void)updateChartData:(NSArray *)data {
    self.yValues = data;
    [self updateBar];
}

- (void)updateBar {
    // Add bars
    CGFloat chartCavanHeight = self.frame.size.height - _chartMargin * 2 - xLabelHeight;
    NSInteger index = 0;
    for (NSNumber* vlaueString in _yValues) {
        WWDBar* bar;
        if (_bars.count == _yValues.count) {
            bar = [_bars objectAtIndex:index];
        } else {
            CGFloat barWidth;
            CGFloat barXPosition;
            
            if (_barWidth) {
                barWidth = _barWidth;
//                barXPosition = index * 
            }
        }
    }
}

- (void)setXLabels:(NSArray *)xLabels {
    _xLabels = xLabels;
    if (_xChartLabels) {
        [self viewCleanupForCollection:_xChartLabels];
    } else {
        _xChartLabels = [NSMutableArray new];
    }
    if (_showLabel) {
        _xLabelWidth = (self.frame.size.width - _chartMargin * 2) / [xLabels count];
        int labelAddCount = 0;
        for (int index = 0; index < _xLabels.count; index++) {
            labelAddCount += 1;
            
            if (labelAddCount == _xLabelSkip) {
                NSString* labelText = [_xLabels[index] description];
                UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _xLabelWidth, xLabelHeight)];
                label.font = _labelFont;
                label.textColor = _labelTextColor;
                [label setTextAlignment:NSTextAlignmentCenter];
                label.text = labelText;
                // [label sizeToFit];
                CGFloat labelXPosition;
                if (_rotateForXAxisText) {
                    label.transform = CGAffineTransformMakeRotation(M_PI / 4);
                    labelXPosition = (index * _xLabelWidth + _chartMargin + _xLabelWidth / 1.5);
                } else {
                    labelXPosition = (index * _xLabelWidth + _chartMargin + _xLabelWidth / 2.0);
                }
                label.center = CGPointMake(labelXPosition, self.frame.size.height - xLabelHeight - _chartMargin + label.frame.size.height / 2.0 + _labelMarginTop);
                labelAddCount = 0;
                [_xChartLabels addObject:label];
                [self addSubview:label];
            }
        }
    }
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
}


@end
