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

@property (nonatomic) BOOL grade;
@property (nonatomic, strong) CAShapeLayer* gradientMask;

@end

@implementation MyBar

- (id)initWithFrame:(CGRect)frame andStrokeColor:(UIColor*)strokeColor bgColor:(UIColor*)bgColor barWidth:(CGFloat)barWidth  withGrade:(BOOL)grade theColor:(UIColor*)gradeColor {
    self = [super initWithFrame:frame];
    if (self) {
        _barLayer = [CAShapeLayer layer]; // 初始化 bar 条
        _strokeColor = strokeColor; // bar 的前景色
        _backgroundColor = bgColor; // bar 的背景色
        _barWidth = barWidth; // bar 宽
        _barValue = 0.0f; // bar 的初始值
        [self strokeBackground]; // 设置 background

        _path = [UIBezierPath bezierPath];
        _barLayer.path = [self getUIBezierPath].CGPath;
        _barLayer.strokeColor = _strokeColor.CGColor;
        _barLayer.fillColor = [UIColor clearColor].CGColor;
        _barLayer.lineWidth = _barWidth;
        _barLayer.strokeEnd = _barValue;
        [self gradeSetting:grade withColor:gradeColor];
        _grade = grade;
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
    if (_grade) {
        _gradientMask.strokeEnd = value;
        [_gradientMask addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
    
    [_barLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    _barValue = value;
}

// 设置背景, 带圆角, 剪切子视图
- (void)strokeBackground {
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    _bgLayer = [CALayer layer];
    _bgLayer.frame = CGRectMake((self.bounds.size.width - _barWidth) / 2, 0.0, _barWidth, self.bounds.size.height);
    _bgLayer.backgroundColor = _backgroundColor.CGColor;
    _bgLayer.cornerRadius = BAR_CORNER_RADIUS; // 圆角大小
    _bgLayer.masksToBounds = YES; // 剪切子视图
    [self.layer addSublayer:_bgLayer]; // 将背景添加到当前 layer
    [_bgLayer addSublayer:_barLayer]; // 再将 barLayer 添加到 bgLayer 上
}

- (UIBezierPath*)getUIBezierPath {
    [_path moveToPoint:CGPointMake(_barLayer.superlayer.bounds.size.width / 2, _barLayer.superlayer.bounds.size.height)];
    [_path addLineToPoint:CGPointMake(_barLayer.superlayer.bounds.size.width / 2, 0.0)];
    return _path;
}

// 设置渐变
- (void)gradeSetting:(BOOL)grade withColor:(UIColor*)gradeColor {
    if (grade) {
        _gradientMask = [CAShapeLayer layer];
        _gradientMask.fillColor = [UIColor clearColor].CGColor;
        _gradientMask.strokeColor = [UIColor blackColor].CGColor;
        _gradientMask.lineWidth = self.frame.size.width;
        _gradientMask.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _gradientMask.path = _barLayer.path;
            
        CAGradientLayer* gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0.5, 0.0);
        gradientLayer.endPoint = CGPointMake(0.5, 1.0);
        // 设置渐变的位置: gradeColor 由 0.0 开始 到 0.4 变成 strokeColor
        [gradientLayer setLocations:@[@0.0, @0.4]];
        gradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        UIColor* startColor = gradeColor ? gradeColor : [UIColor redColor];
        NSArray* colors = @[(id)startColor.CGColor, (id)_strokeColor.CGColor];
        gradientLayer.colors = colors;
        [gradientLayer setMask:_gradientMask];
        
        [_barLayer addSublayer:gradientLayer];
        self.gradientMask.strokeEnd = _barValue;
    }
}

@end
