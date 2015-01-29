//
//  WWDChartDelegate.h
//  WWDChart
//
//  Created by maginawin on 15-1-29.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WWDChartDelegate <NSObject>

@optional

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex;

- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex;

- (void)userClickedOnBarAtIndex:(NSInteger)barIndex;

@required

@end