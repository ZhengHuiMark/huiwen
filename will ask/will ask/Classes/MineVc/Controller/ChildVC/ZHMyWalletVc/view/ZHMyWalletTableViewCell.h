//
//  ZHMyWalletTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/1.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHWalletModel;

@interface ZHMyWalletTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Balance;

@property(nonatomic,strong)ZHWalletModel *model;


@end
