//
//  ZHFocusMeListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHFocusMeUserModel;
@interface ZHFocusMeListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *cerTitle;
@property (weak, nonatomic) IBOutlet UILabel *focusTime;

@property (nonatomic,strong)ZHFocusMeUserModel *model;


@end
