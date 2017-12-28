//
//  ZHOrderDetailPayTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHOrderDetailModel;
@interface ZHOrderDetailPayTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeTitle;
@property (weak, nonatomic) IBOutlet UILabel *payStatus;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceNumber;
@property (weak, nonatomic) IBOutlet UILabel *creatTime;

@property(nonatomic,strong)ZHOrderDetailModel *model;

@end
