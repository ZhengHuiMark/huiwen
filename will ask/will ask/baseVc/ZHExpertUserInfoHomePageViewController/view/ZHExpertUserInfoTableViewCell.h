//
//  ZHExpertUserInfoTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHExpertUserInfoModel;

@interface ZHExpertUserInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *hoor;
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *cerTitle;
@property (weak, nonatomic) IBOutlet UILabel *PersonalProfile;
@property (weak, nonatomic) IBOutlet UILabel *Numbers;

@property (nonatomic,strong)ZHExpertUserInfoModel *expertUserInfoModel;


@end
