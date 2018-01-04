//
//  ZHTotalIncomeTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/4.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHTotalIncomeTableViewCell.h"
#import "ZHTotalIncomeModel.h"
@implementation ZHTotalIncomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTotalIncomeModel:(ZHTotalIncomeModel *)totalIncomeModel{
    _totalIncomeModel = totalIncomeModel;
    
    self.totalIncome.text = [NSString stringWithFormat:@"学习一下总收入:%@",self.totalIncomeModel.data];
}
@end
