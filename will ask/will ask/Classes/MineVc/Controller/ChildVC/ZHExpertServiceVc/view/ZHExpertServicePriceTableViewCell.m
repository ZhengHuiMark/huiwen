//
//  ZHExpertServicePriceTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertServicePriceTableViewCell.h"
#import "ZHExpertServiceListModel.h"

@interface ZHExpertServicePriceTableViewCell()<UITextFieldDelegate>

@end

@implementation ZHExpertServicePriceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [_priceTextFiled setBorderStyle:UITextBorderStyleNone];
}

- (void)setPriceModel:(ZHExpertServiceListModel *)priceModel{
    _priceModel = priceModel;
    
    self.priceTextFiled.text = self.priceModel.consultPrice;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.priceTextFiled) {
        !self.didClick?:self.didClick();
    }
    
    
    return YES;
}

@end
