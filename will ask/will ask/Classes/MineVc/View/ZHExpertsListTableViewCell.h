//
//  ZHExpertsListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/9/15.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@interface ZHExpertsListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *foucsMeLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeNumber;
@property (weak, nonatomic) IBOutlet UILabel *NewConsultingNumber;

@property(nonatomic,strong) UserModel *userModel;

@end
