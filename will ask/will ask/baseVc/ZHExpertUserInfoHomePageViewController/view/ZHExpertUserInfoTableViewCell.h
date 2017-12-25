//
//  ZHExpertUserInfoTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHExpertUserInfoModel;

@interface ZHExpertUserInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *hoor;
@property (weak, nonatomic) IBOutlet UILabel *companyAndDuty;
@property (weak, nonatomic) IBOutlet UILabel *cerTitle;
@property (weak, nonatomic) IBOutlet UILabel *numbers;
@property (weak, nonatomic) IBOutlet UILabel *intro;

@property (nonatomic,strong)ZHExpertUserInfoModel *expertUserInfoModel;

@end
