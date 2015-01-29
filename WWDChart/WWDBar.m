//
//  WWDBar.m
//  WWDChart
//
//  Created by maginawin on 15-1-29.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import "WWDBar.h"

@implementation WWDBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValue];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaultValue];
    }
    return self;
}

- (void)setDefaultValue {
    _chartLine = [CAShapeLayer layer];
    _chartLine.lineCap = kCALineCapButt;
    _chartLine.fillColor = [[UIColor whiteColor] CGColor];
    _chartLine.lineWidth = self.frame.size.width;
    _chartLine.strokeEnd = 0.0;
    self.clipsToBounds = YES; // 若为 NO, 超出边界不会被裁剪, 反之会被裁剪
    [self.layer addSublayer:_chartLine];
    _barRadius = 2.0;
}

#pragma mark - Reset property like setBarRadius etc.

- (void)setBarRadius:(CGFloat)barRadius {
    _barRadius = barRadius;
    self.layer.cornerRadius = _barRadius;
}

- (void)setGrade:(float)grade {
    NSLog(@"New grade %f", grade);
    
    UIBezierPath* progressLine = [UIBezierPath bezierPath];
    [progressLine moveToPoint:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height)];
    [progressLine addLineToPoint:CGPointMake(self.frame.size.width / 2.0, (1 - grade) * self.frame.size.height)];
    [progressLine setLineWidth:1.0];
    [progressLine setLineCapStyle:kCGLineCapSquare];
    
    if (_barColor) {
        _chartLine.strokeColor = [_barColor CGColor];
    } else {
        _chartLine.strokeColor = [UIColor greenColor].CGColor;
    }
    
    if (_grade) {
        CABasicAnimation* pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.fromValue = (__bridge id)_chartLine.path;
        pathAnimation.toValue = (__bridge id)(progressLine.CGPath);
        pathAnimation.duration = 0.5f;
        pathAnimation.autoreverses = NO; // reverse 相反
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _chartLine.path = progressLine.CGPath;
        if (_barColorGradientStart) {
            // Add gradient
            [_gradientMask addAnimation:pathAnimation forKey:@"animationKey"];
            _gradientMask.path = progressLine.CGPath;
        }
    } else {
        CABasicAnimation* pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 1.0f;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = @0.0f;
        pathAnimation.toValue = @1.0f;
        [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        _chartLine.strokeEnd = 1.0;
        _chartLine.path = progressLine.CGPath;
        
        if (_barColorGradientStart) {
            self.gradientMask = [CAShapeLayer layer];
            _gradientMask.fillColor = [UIColor clearColor].CGColor;
            _gradientMask.strokeColor = [UIColor blackColor].CGColor;
            _gradientMask.lineWidth = self.frame.size.width;
            _gradientMask.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
            _gradientMask.path = progressLine.CGPath;
            
            CAGradientLayer* gradientLayer = [CAGradientLayer layer];
            gradientLayer.startPoint = CGPointMake(0.5, 1.0);
            gradientLayer.endPoint = CGPointMake(0.5, 0.0);
            gradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
            UIColor* endColor = (_barColor ? _barColor : [UIColor greenColor]);
            NSArray* colors = @[(id)_barColorGradientStart.CGColor, (id)endColor.CGColor];
            gradientLayer.colors = colors;
            [gradientLayer setMask:_gradientMask];
            [_chartLine addSublayer:gradientLayer];
            _gradientMask.strokeEnd = 1.0;
            [_gradientMask addAnimation:pathAnimation forKey:@"storkeEndAnimation"];
        }
    }
    
    _grade = grade;
}

- (void)rollBack {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^ {
        _chartLine.strokeColor = [UIColor clearColor].CGColor;
    } completion:nil];
}

- (void)setBarColorGradientStart:(UIColor *)barColorGradientStart {
    for (CALayer* subLayer in [_chartLine sublayers]) {
        [subLayer removeFromSuperlayer];
    }
    _barColorGradientStart = barColorGradientStart;		
    
    [self setGrade:_grade];
}

// Only override drawRect: if you perform custom drawing
// An empty implementation adversely affects performance during animation
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
}

@end
