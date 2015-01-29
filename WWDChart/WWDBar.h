//
//  WWDBar.h
//  WWDChart
//
//  Created by maginawin on 15-1-29.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWDBar : UIView

- (void)rollBack;

@property (nonatomic) float grade; // 级别
@property (nonatomic, strong) CAShapeLayer* chartLine;
@property (nonatomic, strong) UIColor* barColor;
@property (nonatomic, strong) UIColor* barColorGradientStart;
@property (nonatomic) CGFloat barRadius;
@property (nonatomic, strong) CAShapeLayer* gradientMask;

@end
