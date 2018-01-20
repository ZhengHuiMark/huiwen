//
//  ZHOrderPayContentTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHOrderPayModel;
@interface ZHOrderPayContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderState;
@property (weak, nonatomic) IBOutlet UILabel *orderTitle;
@property (weak, nonatomic) IBOutlet UILabel *priceNumber;
@property (weak, nonatomic) IBOutlet UILabel *creatTime;

@property (nonatomic,strong) ZHOrderPayModel *model ;


@end
