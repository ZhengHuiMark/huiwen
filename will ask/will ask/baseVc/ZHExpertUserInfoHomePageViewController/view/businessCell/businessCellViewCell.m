//
//  businessCellViewCell.m
//  btnCellDemo
//
//  Created by lzhl_iOS on 2017/12/28.
//  Copyright © 2017年 lzhl_iOS. All rights reserved.
//

#import "businessCellViewCell.h"
#import "Masonry.h"


#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#import "ButtonView.h"

@interface businessCellViewCell ()

@property(nonatomic, weak) UILabel *nameLabel;

@property(nonatomic, strong) ButtonView *btnView;

@end

@implementation businessCellViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}



- (void)setupUI {
 
//    self.backgroundColor = randomColor;
    
    UILabel *nameLa = [UILabel new];
    nameLa.text = @"擅长业务";
    self.nameLabel = nameLa;
    nameLa.frame = CGRectMake(15, 10, 100, 30);
    [self.contentView addSubview:nameLa];

    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor darkGrayColor];
    lineView.frame = CGRectMake(15, 50, [UIScreen mainScreen].bounds.size.width, 1);
    [self.contentView addSubview:lineView];
    
    self.btnView = [ButtonView new];
    [self.contentView addSubview:self.btnView];
}

- (void)setBtnStrDataSoure:(NSString *)btnStrDataSoure {
    
    _btnStrDataSoure = btnStrDataSoure;
    
    self.btnView.btnStr = btnStrDataSoure;
    
    NSArray *temp = [btnStrDataSoure componentsSeparatedByString:@","];

    if (temp.count > 4) {
        self.btnView.frame = CGRectMake(0, 61, [UIScreen mainScreen].bounds.size.width, 90);
    }else {
        self.btnView.frame = CGRectMake(0, 61, [UIScreen mainScreen].bounds.size.width, 50);
    }
}



@end
