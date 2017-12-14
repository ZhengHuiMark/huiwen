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
    
    self.moneyL.text = self.numberModel.amount;
    [self.cardImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameDwsoft,OSS,self.numberModel.photo]]];
    
}

- (IBAction)selectedInvoice:(UIButton *)sender {
    
}


- (IBAction)buyBtnAction:(UIButton *)sender {
    
}


@end
