//
//  ZHWalletListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/1.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHWalletListTableViewCell : UITableViewCell


@property(nonatomic,strong)NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
