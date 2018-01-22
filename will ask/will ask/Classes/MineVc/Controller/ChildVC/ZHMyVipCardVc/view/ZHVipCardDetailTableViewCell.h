//
//  ZHVipCardDetailTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHVipCardModel,ZHCardNumberModel;
typedef void(^buyCardClick)();

@interface ZHVipCardDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cardImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *moneyL;

@property(nonatomic,strong)ZHVipCardModel *vipModel;

@property(nonatomic,strong)ZHCardNumberModel *numberModel;

@property(nonatomic,copy)buyCardClick didClick;

@end
