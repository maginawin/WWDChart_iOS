//
//  MyBarChart.h
//  WWDChart
//
//  Created by maginawin on 15-1-29.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBar.h"

@interface MyBarChart : UIView

@property (nonatomic, strong) NSMutableArray* myBars;

/** 初始化参数, 一定要调用 */
- (void)setupCounts:(NSInteger)counts xyAxisColor:(UIColor*)xyColor labelColor:(UIColor*)labelColor barColor:(UIColor*)barColor barBgColor:(UIColor*)barBgColor;

/** 添加的方法, 暂时不对公 */
//- (void)addBar:(CGFloat)value atIndex:(NSInteger)index withXName:(NSString*)xName;

@end
