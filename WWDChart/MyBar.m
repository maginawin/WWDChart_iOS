//
//  MyBar.m
//  WWDChart
//
//  Created by maginawin on 15-1-29.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import "MyBar.h"

@interface MyBar()

@property (nonatomic, strong) CAShapeLayer* barLayer;
@property (nonatomic ,strong) CALayer* bgLayer;
@property (nonatomic, strong) UIColor* strokeColor;
@property (nonatomic, strong) UIColor* backgroundColor;
@property (nonatomic) CGFloat barWidth;
@property (nonatomic, strong) UIBezierPath* path;

@end

@implementation MyBar

- (id)initWithFrame:(CGRect)frame andStrokeColor:(UIColor*)strokeColor bgColor:(UIColor*)bgColor barWidth:(CGFloat)barWidth {
    self = [super initWithFrame:frame];
    if (self) {
        _barLayer = [CAShapeLayer layer];
        _strokeColor = strokeColor;
        _backgroundColor = bgColor;
        _barWidth = barWidth;
        _barValue = 0.0f;
        [self strokeBackground];
        _path = [UIBezierPath bezierPath];
        _barLayer.path = [self getUIBezierPath].CGPath;
        _barLayer.strokeColor = _strokeColor.CGColor;
        _barLayer.fillColor = [UIColor clearColor].CGColor;
        _barLayer.lineWidth = _barWidth;
        _barLayer.strokeEnd = _barValue;
    }
    return self;
}

- (void)updateBarValue:(CGFloat)value {
    
    // Add animation
    CABasicAnimation* pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5f;
    pathAnimation.fromValue = @(_barValue);
    pathAnimation.toValue = @(value);
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _barLayer.strokeEnd = value;
    [_barLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    _barValue = value;
}

- (void)strokeBackground {
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    _bgLayer = [CALayer layer];
    _bgLayer.frame = CGRectMake((self.bounds.size.width - _barWidth) / 2, 0.0, _barWidth, self.bounds.size.height);
    _bgLayer.backgroundColor = _backgroundColor.CGColor;
    _bgLayer.cornerRadius = BAR_CORNER_RADIUS;
    _bgLayer.masksToBounds = YES;
    [self.layer addSublayer:_bgLayer];
    [_bgLayer addSublayer:_barLayer];
}

- (UIBezierPath*)getUIBezierPath {
    [_path moveToPoint:CGPointMake(_barLayer.superlayer.bounds.size.width / 2, _barLayer.superlayer.bounds.size.height)];
    [_path addLineToPoint:CGPointMake(_barLayer.superlayer.bounds.size.width / 2, 0.0)];
    return _path;
}

@end
