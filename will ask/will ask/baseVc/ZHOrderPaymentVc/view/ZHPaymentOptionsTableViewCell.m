//
//  ZHPaymentOptionsTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHPaymentOptionsTableViewCell.h"

@implementation ZHPaymentOptionsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    switch (indexPath.row) {
        case 0:{
            self.payTitle.text = @"微信支付";
            self.payImage.image = [UIImage imageNamed:@"weixin"];
        }
            break;
        case 1:{
            self.payTitle.text = @"支付宝支付";
            self.payImage.image = [UIImage imageNamed:@"zhifubao"];
        }
            break;
        case 2:{
            self.payTitle.text = @"钱包余额支付";
            self.payImage.image = [UIImage imageNamed:@"qianbao"];
        }
            break;
        case 3:{
            self.payTitle.text = @"会员卡支付";
            self.payImage.image = [UIImage imageNamed:@"yu-e"];
        }
            break;
            
        default:
            break;
    }
}

@end
