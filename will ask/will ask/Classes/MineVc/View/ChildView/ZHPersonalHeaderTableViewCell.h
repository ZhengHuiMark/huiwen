//
//  ZHPersonalHeaderTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/9/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserInfoModel;

typedef void(^UserAvatarCellDidClick)(NSIndexPath *indexPath);


@interface ZHPersonalHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *UserAvatarImg;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) UserAvatarCellDidClick AvatarClick;

@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImageView;

@property (nonatomic, strong) UserInfoModel *UserInfoModel;


@end
