//
//  WWDCircleChartViewController.m
//  WWDChart
//
//  Created by maginawin on 15-1-28.
//  Copyright (c) 2015年 mycj.wwd. All rights reserved.
//

#import "WWDCircleChartViewController.h"
#import "WWDCircleChart.h"

@interface WWDCircleChartViewController ()

@property (strong, nonatomic) WWDCircleChart* circleChart;
@property (strong, nonatomic) NSNumber* current;

@end

@implementation WWDCircleChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _current = @50;
    
    _circleChart = [[WWDCircleChart alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 100.0) total:@100 current:_current clockwise:NO shadow:NO];
    _circleChart.lineWidth = @4.0f;
    _circleChart.chartType = WWDChartFormatTypeDollar;
    _circleChart.backgroundColor = [UIColor clearColor];
    [_circleChart setStrokeColor:[UIColor greenColor]];
    [_circleChart setStrokeColorGradientStart:[UIColor yellowColor]];
    [_circleChart strokeChart];
    
    [self.view addSubview:_circleChart];
}

#pragma mark - IBAction

- (IBAction)add:(id)sender {
    _current = [NSNumber numberWithInteger:([_current intValue] + 2)];
    [_circleChart updateChartByCurrent:_current];
}

- (IBAction)minus:(id)sender {
    _current = [NSNumber numberWithInteger:([_current intValue] - 2)];
    [_circleChart growChartByAmount:@-2];
}

- (IBAction)random:(id)sender {
    [self randomCurrent];
    [_circleChart updateChartByCurrent:_current];
}

#pragma mark - Tools

- (void)randomCurrent {
    _current = [NSNumber numberWithInteger:arc4random() % 101];
}

@end
