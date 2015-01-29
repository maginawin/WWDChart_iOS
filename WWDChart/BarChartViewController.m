//
//  BarChartViewController.m
//  WWDChart
//
//  Created by maginawin on 15-1-29.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import "BarChartViewController.h"
#import "MyBar.h"
#import "MyBarChart.h"

@interface BarChartViewController ()

@property (nonatomic ,strong) MyBarChart* barChart;

@end

@implementation BarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _barChart = [[MyBarChart alloc] initWithFrame:CGRectMake(0, 80, 320, 160)];
    _barChart.backgroundColor = [UIColor whiteColor];
    [_barChart setupCounts:7 xyAxisColor:[UIColor redColor] labelColor:[UIColor grayColor] barColor:[UIColor blueColor] barBgColor:[UIColor lightGrayColor]];
    [self.view addSubview:_barChart];
}

- (void)viewDidAppear:(BOOL)animated {
    
//    NSTimer* timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateBarValue) userInfo:nil repeats:YES];
//    [timer fire];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateBarValue) userInfo:nil repeats:YES];
    
}

- (void)updateBarValue {
    for (int i = 0; i < 7; i++) {
        float ra = (float)(arc4random() % 11 / 10.0);
        [[_barChart.myBars objectAtIndex:i] updateBarValue:ra];
    }
}

@end
