//
//  CircleView.m
//  YKL
//
//  Created by Apple on 15/12/7.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "XLCircleProgress.h"
#import "XLCircle.h"

@implementation XLCircleProgress
{
    XLCircle* _circle;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}


-(void)initUI
{
    
    CGFloat percentLabelWidth = [UIScreen mainScreen].bounds.size.width - 80;
    CGFloat percentLabelHeight = 30;
    CGFloat percentLabelX = CGRectGetMinX(self.frame) + 40;
    CGFloat percentLabelY = CGRectGetMinY(self.frame) + 40;
    
    float lineWidth = 0.1*self.bounds.size.width;
    _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(percentLabelX, percentLabelY, percentLabelWidth, percentLabelHeight)];
    _percentLabel.textAlignment = NSTextAlignmentCenter;
    _percentLabel.font = [UIFont boldSystemFontOfSize:24];
    _percentLabel.text = @"￥0";
    _percentLabel.textColor = [UIColor orangeColor];
    

    [self addSubview:_percentLabel];
    
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.frame = CGRectMake(percentLabelX, CGRectGetMaxY(_percentLabel.frame) + 5, percentLabelWidth, percentLabelHeight);
    textLabel.textAlignment = NSTextAlignmentCenter;

    textLabel.text = @"我的悬赏价格";
    
    [self addSubview:textLabel];


//    _circle = [[XLCircle alloc] initWithFrame:self.bounds lineWidth:lineWidth];
//    [self addSubview:_circle];
}



#pragma mark -
#pragma mark Setter方法
-(void)setProgress:(float)progress
{
    _progress = progress;
    _circle.progress = progress;
    _percentLabel.text = [NSString stringWithFormat:@"￥%.0f",progress*200];
    _percentLabel.textColor = [UIColor orangeColor];
    NSLog(@"%@",_percentLabel.text);
}




@end
