//
//  ZHMyorderTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/6.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyorderTableViewCell.h"
#import "ZHMyOrderModel.h"

@implementation ZHMyorderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.payForBtn setCornerRadius:15];
}

-(void)setOrderModel:(ZHMyOrderModel *)orderModel {
    _orderModel = orderModel;
    
    self.generateTimeL.text = [NSString stringWithFormat:@"订单生成时间:%@",self.orderModel.createTime];
    self.money.text = self.orderModel.amount;
    self.titleL.text = self.orderModel.goodsName;
    
    if ([self.orderModel.type isEqualToString:@"1"]) {
        self.TypeName.text = @"悬赏问订单";

    }
    if ([self.orderModel.type isEqualToString:@"2"]) {
        self.TypeName.text = @"学习一下订单";

    }
    if ([self.orderModel.type isEqualToString:@"3"]) {
        self.TypeName.text = @"案例订单";

    }
    if ([self.orderModel.type isEqualToString:@"4"]) {
        self.TypeName.text = @"咨询订单";

    }
    if ([self.orderModel.type isEqualToString:@"5"]) {
        self.TypeName.text = @"会员卡订单";
        
    }

    switch (self.orderModel.status) {
        case ReviewStatusWaitPayFor:{
            
                    self.closeTime.hidden = YES;
                    self.payForBtn.hidden = NO;
                    [self.payForBtn setTitle:@"支付" forState:UIControlStateNormal];
                    [self.payForBtn.layer setBorderColor:[UIColor redColor].CGColor];
                    [self.payForBtn.layer setBorderWidth:1];
                    [self.payForBtn.layer setMasksToBounds:YES];
                    self.payLabel.hidden = YES;
                    self.PayStatus.text = @"等待支付";
        }
            break;
        case ReviewStatusCancel:{
//                    self.closeTime.hidden = YES;
                    self.orderDetailL.text = @"订单详情";
            
                    self.payForBtn.hidden = YES;
                    self.payLabel.hidden = NO;
                    self.payLabel.text = self.orderModel.payMode;
                    self.closeTime.text = [NSString stringWithFormat:@"订单支付时间:%@",self.orderModel.payTime];
                    self.PayStatus.text = @"已完成";
        }
            break;
        case ReviewStatusSuccess:{
            
                    self.closeTime.text = [NSString stringWithFormat:@"订单关闭时间:%@",self.orderModel.closeTime];
                    self.orderDetailL.text = @"订单详情";
                    self.payForBtn.hidden = YES;
                    self.payLabel.hidden = YES;
                    self.PayStatus.text = @"已关闭";
            
        }
            break;
            
        default:
            break;
    }

}

- (IBAction)payAction:(UIButton *)sender {
    
    !self.didClick?:self.didClick();
}



@end
