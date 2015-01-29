//
//  WWDCircleChart.m
//  WWDChart
//
//  Created by maginawin on 15-1-28.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import "WWDCircleChart.h"

@interface WWDCircleChart()

@property (strong, nonatomic) NSString* format;

@end

@implementation WWDCircleChart

- (id)initWithFrame:(CGRect)frame total:(NSNumber *)total current:(NSNumber *)current clockwise:(BOOL)clockwise shadow:(BOOL)hasBackgroundShadow {
    self = [super initWithFrame:frame];
    if (self) {
        _total = total;
        _current = current;
        _strokeColor = [UIColor greenColor];
        _duration = 1.0;
        _chartType = WWDChartFormatTypePercent;
        
        CGFloat startAngle = clockwise ? -90.0f : 270.0f;
        CGFloat endAngle = clockwise ? -90.01f : 270.01f;
        
        _lineWidth = @8.0f;
        UIBezierPath* circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width / 2, frame.size.height / 2) radius:(self.frame.size.height * 0.5) - [_lineWidth floatValue] startAngle:DEGREES_TO_RADIANS(startAngle) endAngle:DEGREES_TO_RADIANS(endAngle) clockwise:clockwise];
        
        _circle = [CAShapeLayer layer];
        _circle.path = circlePath.CGPath;
        _circle.lineCap = kCALineCapRound;
        _circle.fillColor = [UIColor clearColor].CGColor;
        _circle.lineWidth = [_lineWidth floatValue];
        _circle.zPosition = 1;
        
        _circleBackground = [CAShapeLayer layer];
        _circleBackground.path = circlePath.CGPath;
        _circleBackground.lineCap = kCALineCapRound;
        _circleBackground.fillColor = [UIColor clearColor].CGColor;
        _circleBackground.lineWidth = [_lineWidth floatValue];
        _circleBackground.strokeColor = (hasBackgroundShadow ? [UIColor grayColor].CGColor : [UIColor clearColor].CGColor);
        _circleBackground.strokeEnd = 1.0;
        _circleBackground.zPosition = -1;
        
        [self.layer addSublayer:_circle];
        [self.layer addSublayer:_circleBackground];
        
        _countingLabel = [[UILabel alloc] initWithFrame:frame];
        [_countingLabel setTextAlignment:NSTextAlignmentCenter];
        [_countingLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [_countingLabel setTextColor:[UIColor grayColor]];
        [_countingLabel setBackgroundColor:[UIColor clearColor]];
        [_countingLabel setCenter:CGPointMake(frame.size.width / 2, frame.size.height / 2)];
        
        [self addSubview:_countingLabel];
    }
    return self;
}

- (void)strokeChart {
    switch (self.chartType) {
        case WWDChartFormatTypeDollar: {
            _format = @"$%d";
            break;
        }
        case WWDChartFormatTypePercent: {
            _format = @"%d%%";
            break;
        }
        case WWDChartFormatTypeNone:
            _format = @"%d";
            break;
        default:
            break;
    }
    
    // Add circle params
    _circle.lineWidth = [_lineWidth floatValue];
    _circleBackground.lineWidth = [_lineWidth floatValue];
    _circleBackground.strokeEnd = 1.0;
    _circle.strokeColor = _strokeColor.CGColor;
    
    // Add animation
    CABasicAnimation* pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = _duration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @0.0f;
    pathAnimation.toValue = @([_current floatValue] / [_total floatValue]);
    [_circle addAnimation:pathAnimation forKey:@"storkeAnimation"];
    _circle.strokeEnd = [_current floatValue] / [_total floatValue];
    
    _countingLabel.text = [NSString stringWithFormat:_format, [_current intValue]];
    
    // Check if user wants to add a gradient from the start color to the bar color
    if (_strokeColorGradientStart) {
        // Add gradient
        _gradientMask = [CAShapeLayer layer];
        _gradientMask.fillColor = [UIColor clearColor].CGColor;
        _gradientMask.strokeColor = [UIColor blackColor].CGColor;
        _gradientMask.lineWidth = _circle.lineWidth;
        _gradientMask.lineCap = kCALineCapRound;
        CGRect gradientFrame = CGRectMake(0, 0, self.bounds.size.width * 2, self.bounds.size.height * 2);
        self.gradientMask.frame = gradientFrame;
        self.gradientMask.path = _circle.path;
        
        CAGradientLayer* gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0.5, 0.5);
        gradientLayer.endPoint = CGPointMake(0.5, 0.0);
        
        //test
//        gradientLayer.locations = @[];
        
        gradientLayer.frame = gradientFrame;
        UIColor* endColor = (_strokeColor ? _strokeColor : [UIColor greenColor]);
        NSArray* colors = @[(id)endColor.CGColor, (id)_strokeColorGradientStart.CGColor];
        gradientLayer.colors = colors;
        [gradientLayer setMask:self.gradientMask];
        [_circle addSublayer:gradientLayer];
        _gradientMask.strokeEnd = [_current floatValue] / [_total floatValue];
        [_gradientMask addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
}

- (void)growChartByAmount:(NSNumber *)growAmount {
    NSNumber* updatedValue = [NSNumber numberWithFloat:[_current floatValue] + [growAmount floatValue]];
    [self updateChartByCurrent:updatedValue];
}

- (void)updateChartByCurrent:(NSNumber *)current {
    CABasicAnimation* pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = _duration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @([_current floatValue] / [_total floatValue]);
    pathAnimation.toValue = @([current floatValue] / [_total floatValue]);
    _circle.strokeEnd = [current floatValue] / [_total floatValue];
    if (_strokeColorGradientStart) {
        _gradientMask.strokeEnd = _circle.strokeEnd;
        [_gradientMask addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
    [_circle addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    _countingLabel.text = [NSString stringWithFormat:_format, [current intValue]];
    _current = current;
}

@end
