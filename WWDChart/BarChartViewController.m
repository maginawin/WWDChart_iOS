//
//  BarChartViewController.m
//  WWDChart
//
//  Created by maginawin on 15-1-29.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import "BarChartViewController.h"
#import "MyBarChart.h"

@interface BarChartViewController ()

@property (nonatomic ,strong) MyBarChart* barChart;

@end

@implementation BarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _barChart = [[MyBarChart alloc] initWithFrame:CGRectMake(0, 80, 320, 320)];
    _barChart.backgroundColor = [UIColor whiteColor];
    [_barChart setupCounts:7 xyAxisColor:[UIColor darkGrayColor]  yArray:@[@"0", @"2500", @"5000", @"7500", @"10000"] labelColor:[UIColor darkTextColor] barColor:[UIColor purpleColor] barBgColor:[UIColor lightGrayColor] barGrade:YES gradeColor:[UIColor whiteColor]];
    [self.view addSubview:_barChart];
}

- (void)viewDidAppear:(BOOL)animated {
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateBarValue) userInfo:nil repeats:YES];    
}

- (void)updateBarValue {
    for (int i = 0; i < 7; i++) {
        float ra = (float)(arc4random() % 11 / 10.0);
//        [[_barChart.myBars objectAtIndex:i] updateBarValue:ra];
//        [(UILabel*)[_barChart.myXLabels objectAtIndex:i] setText:[NSString stringWithFormat:@"%.1f", ra]];
        [_barChart updateBarValue:ra barXText:[NSString stringWithFormat:@"%.1f", ra] atIndex:i];
    }
}

@end
