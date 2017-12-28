//
//  ZHOrderDetailLearnTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHOrderDetailLearnModel;
@interface ZHOrderDetailLearnTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (nonatomic,strong)ZHOrderDetailLearnModel *model;

@end
