//
//  ZHRewardMoneyViewController.m
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardMoneyViewController.h"
#import "XLCircleProgress.h"

@interface ZHRewardMoneyViewController ()
{
    XLCircleProgress *_circle;
}

@end

@implementation ZHRewardMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCircle];

    
    self.view.backgroundColor = [UIColor grayColor];
    
}



-(void)addCircle
{
    //    CGFloat margin = 15.0f;
    CGFloat circleWidth = [UIScreen mainScreen].bounds.size.width - 2;
    _circle = [[XLCircleProgress alloc] initWithFrame:CGRectMake(0,0, circleWidth, 300)];
    _circle.center = self.view.center;
    _circle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_circle];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, CGRectGetMinY(_circle.frame) + circleWidth - 200, self.view.bounds.size.width - 2*50, 30)];
    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
    [slider setMaximumValue:1];
    [slider setMinimumValue:0];
    [slider setMinimumTrackTintColor:[UIColor colorWithRed:255.0f/255.0f green:151.0f/255.0f blue:0/255.0f alpha:1]];
    [slider setThumbTintColor:[UIColor orangeColor]];
    [self.view addSubview:slider];
    
    UILabel *number1 = [[UILabel alloc]init];
    number1.frame = CGRectMake(50, CGRectGetMaxY(slider.frame) + 3, 10, 15);
    number1.text = @"0";
    number1.font = [UIFont systemFontOfSize:15];
    number1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    
    [self.view addSubview:number1];
    
    UILabel *number2 = [[UILabel alloc]init];
    number2.frame = CGRectMake(CGRectGetMaxX(number1.frame) + 131, CGRectGetMaxY(slider.frame) + 3,30, 15);
    number2.text = @"100";
    number2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:number2];
    
    UILabel *number3 = [[UILabel alloc]init];
    number3.frame = CGRectMake(CGRectGetMaxX(number2.frame) + 115, CGRectGetMaxY(slider.frame) + 3, 30, 15);
    number3.text = @"200";
    number3.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:number3];
    
}

 - (void)sliderMethod:(UISlider*)slider
{
    _circle.progress = slider.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
