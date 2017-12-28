//
//  ZHOrderDetailVipCardTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHOrderDetailVipCardModel;
@interface ZHOrderDetailVipCardTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property(nonatomic,strong)ZHOrderDetailVipCardModel *vipModel;

@end
