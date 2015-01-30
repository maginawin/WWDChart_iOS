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

/** 存储显示的所有 MyBar */
@property (nonatomic, strong) NSMutableArray* myBars;
/** 存储 x 轴所有 UILabel */
@property (nonatomic, strong) NSMutableArray* myXLabels;
/** 存储 y 轴所有 UILabel */
@property (nonatomic, strong) NSMutableArray* myYLables;

/** 初始化参数, 一定要调用 */
- (void)setupCounts:(NSInteger)counts xyAxisColor:(UIColor*)xyColor  yArray:(NSArray*)yArray labelColor:(UIColor*)labelColor barColor:(UIColor*)barColor barBgColor:(UIColor*)barBgColor barGrade:(BOOL)grade gradeColor:(UIColor*)gradeColor;

/** 添加的方法, 暂时不对公 */
//- (void)addBar:(CGFloat)value atIndex:(NSInteger)index withXName:(NSString*)xName;

@end
