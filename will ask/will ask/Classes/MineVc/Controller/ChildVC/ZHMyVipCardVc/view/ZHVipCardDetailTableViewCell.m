//
//  ZHVipCardDetailTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHVipCardDetailTableViewCell.h"
#import "ZHVipCardModel.h"
#import "ZHCardNumberModel.h"
#import "ZHNetworkTools.h"
#import "Macro.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"


@implementation ZHVipCardDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setVipModel:(ZHVipCardModel *)vipModel{
    _vipModel = vipModel;
}

- (void)setNumberModel:(ZHCardNumberModel *)numberModel{
    _numberModel = numberModel;
    
//    self.content.text = self.numberModel.
    
    self.moneyL.text = [NSString stringWithFormat:@"￥%@",self.numberModel.amount];
    self.content.text = self.numberModel.descriptions;
    self.nameLabel.text = self.numberModel.name;
    
    [self.cardImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameDwsoftLoad,OSS,self.numberModel.photo]]];
    
    
}

- (IBAction)selectedInvoice:(UIButton *)sender {
    
    
    if (self.vipModel.invoiceInfoExists == YES) {
        sender.selected = !sender.selected;
        self.vipModel.isInvoice = sender.selected;
    }else{
        [SVProgressHUD showInfoWithStatus:@"您还未添加发票信息，请先添加发票信息"];
    }
}


- (IBAction)buyBtnAction:(UIButton *)sender {
 
    !self.didClick?:self.didClick();
    
}


@end
