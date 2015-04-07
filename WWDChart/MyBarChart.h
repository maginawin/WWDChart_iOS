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

/** 初始化参数, 一定要调用 
 * counts: bar 的数量
 * xyColor: X, Y Axis 的轴颜色
 * yArray: Y Axis 的值数组 (NSString*), 顺序为从 Y 轴的最下开始
 * labelColor: X, Y 轴上标识的字体颜色
 * barColor: bar 的颜色
 * barBgColor: bar 的背景颜色
 * garde: 是否添加渐变
 * gradeColor: 渐变的颜色
 * Tips: 渐变是从上到下的, 上的颜色为 gradeColor, 下的颜色为 barColor
 */
- (void)setupCounts:(NSInteger)counts xyAxisColor:(UIColor*)xyColor  yArray:(NSArray*)yArray labelColor:(UIColor*)labelColor barColor:(UIColor*)barColor barBgColor:(UIColor*)barBgColor barGrade:(BOOL)grade gradeColor:(UIColor*)gradeColor;

- (void)updateBarValue:(CGFloat)value barXText:(NSString*)xText atIndex:(NSInteger)index;

/** 添加的方法, 暂时不对公 */
//- (void)addBar:(CGFloat)value atIndex:(NSInteger)index withXName:(NSString*)xName;

@end
