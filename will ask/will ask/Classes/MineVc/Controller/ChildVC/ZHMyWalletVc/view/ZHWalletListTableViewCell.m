//
//  ZHWalletListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/1.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHWalletListTableViewCell.h"

@implementation ZHWalletListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    switch (indexPath.row) {
        case 0:
            self.titleLabel.text = @"提现到微信余额";
            break;
        case 1:
            self.titleLabel.text = @"交易记录";
            break;
        case 2:
            self.titleLabel.text = @"提现记录";
            break;
            
        default:
            break;
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
