//
//  ZHMyCardNumberTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyCardNumberTableViewCell.h"
#import "ZHVipCardModel.h"

@implementation ZHMyCardNumberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ZHVipCardModel *)model{
    _model = model;
    
    self.CardNumber.text = self.model.balance;
    
}

- (IBAction)invoiceAction:(UIButton *)sender {
    
    !self.invoiceBtnClick?:self.invoiceBtnClick();
    
}

- (IBAction)recordAction:(id)sender {
    
    !self.recordBtnClick?:self.recordBtnClick();
    
}


@end
