//
//  ZHSetUpIdentityTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/26.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHAskIdModel;
@interface ZHSetUpIdentityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userTitle;

@property (nonatomic,strong)ZHAskIdModel *model;

@end
