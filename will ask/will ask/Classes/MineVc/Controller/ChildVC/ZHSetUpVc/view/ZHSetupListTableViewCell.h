//
//  ZHSetupListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/2.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHSetupListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property(nonatomic,copy)NSIndexPath *indexPath;

@end
