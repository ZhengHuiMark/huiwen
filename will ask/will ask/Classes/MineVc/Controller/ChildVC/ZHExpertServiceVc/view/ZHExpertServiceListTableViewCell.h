//
//  ZHExpertServiceListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHExpertServiceListModel;
@interface ZHExpertServiceListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *variableLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrowLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailedLabel;

@property(nonatomic,strong) NSIndexPath *indexPath;

@property(nonatomic,strong) ZHExpertServiceListModel *expertServiceModel;



@end
