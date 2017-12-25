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
}

-(void)setOrderModel:(ZHMyOrderModel *)orderModel {
    _orderModel = orderModel;
    
    self.generateTimeL.text = self.orderModel.createTime;
    self.money.text = self.orderModel.amount;
    self.titleL.text = self.orderModel.goodsName;
    self.TypeName.text = self.orderModel.type;
    self.orderDetailL.text = @"订单详情";


    switch (self.orderModel.status) {
        case ReviewStatusWaitPayFor:{
            
                    self.closeTime.hidden = YES;
                    [self.payForBtn setTitle:@"支付" forState:UIControlStateNormal];
                    [self.payForBtn.layer setBorderColor:[UIColor redColor].CGColor];
                    [self.payForBtn.layer setBorderWidth:1];
                    [self.payForBtn.layer setMasksToBounds:YES];
                    self.payLabel.hidden = YES;
                    self.PayStatus.text = @"等待支付";
            //
            
            
        }
            break;
        case ReviewStatusCancel:{ // 完成
                    self.closeTime.hidden = YES;
                    self.orderDetailL.text = @"订单详情";
            
                    self.payForBtn.hidden = YES;
            self.payLabel.text = self.orderModel.payMode;
            self.payLabel.text = @"asdfasdfasdf";

                    self.closeTime.text = self.orderModel.payTime;
                    self.PayStatus.text = @"已完成";
        }
            break;
        case ReviewStatusSuccess:{ // 关闭
            
                    self.closeTime.text = self.orderModel.closeTime;
                    self.orderDetailL.text = @"订单详情";
                    self.payForBtn.hidden = YES;
                    self.payLabel.hidden = YES;
                    self.PayStatus.text = @"已关闭";
            
        }
            break;
            
        default:
            break;
    }
    
   
//    
//    if ([self.orderModel.status isEqualToString:@"0"]) {
//        
//        self.money.text = self.orderModel.amount;
//        self.titleL.text = self.orderModel.goodsName;
//        self.TypeName.text = self.orderModel.type;
//        self.generateTimeL.text = self.orderModel.createTime;
//        self.closeTime.hidden = YES;
//        self.orderDetailL.text = @"订单详情";
//        [self.payForBtn setTitle:@"支付" forState:UIControlStateNormal];
//        [self.payForBtn.layer setBorderColor:[UIColor redColor].CGColor];
//        [self.payForBtn.layer setBorderWidth:1];
//        [self.payForBtn.layer setMasksToBounds:YES];
//        self.payLabel.hidden = YES;
//        self.PayStatus.text = @"等待支付";
//        
//    }else if ([self.orderModel.status isEqualToString:@"1"]) {
//        
//        self.money.text = self.orderModel.amount;
//        self.titleL.text = self.orderModel.goodsName;
//        self.TypeName.text = self.orderModel.type;
//        self.generateTimeL.text = self.orderModel.createTime;
//        self.closeTime.hidden = YES;
//        self.orderDetailL.text = @"订单详情";
//
//        self.payForBtn.hidden = YES;
//        self.payLabel.text = self.orderModel.payMode;
//        self.closeTime.text = self.orderModel.payTime;
//        self.PayStatus.text = @"已完成";
//
//    }else if ([self.orderModel.status isEqualToString:@"2"]) {
//        
//        self.money.text = self.orderModel.amount;
//        self.titleL.text = self.orderModel.goodsName;
//        self.TypeName.text = self.orderModel.type;
//        self.generateTimeL.text = self.orderModel.createTime;
//        self.closeTime.text = self.orderModel.closeTime;
//        self.orderDetailL.text = @"订单详情";
//        self.payForBtn.hidden = YES;
//        self.payLabel.hidden = YES;
//        self.PayStatus.text = @"已关闭";
//
//    }

}

@end
