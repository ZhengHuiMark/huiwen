//
//  ZHWithdrawalRecordTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/4.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHWithdrawalModel;
@interface ZHWithdrawalRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *moneyNumber;

@property (nonatomic,strong)ZHWithdrawalModel *model;

@end
