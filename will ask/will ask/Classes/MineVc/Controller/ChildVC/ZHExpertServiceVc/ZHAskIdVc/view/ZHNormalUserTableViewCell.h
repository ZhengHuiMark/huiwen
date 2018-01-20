//
//  ZHNormalUserTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/26.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@interface ZHNormalUserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *normalAvatar;

@property (weak, nonatomic) IBOutlet UILabel *normalName;

@property (weak, nonatomic) IBOutlet UILabel *cardNumber;

@property (weak, nonatomic) IBOutlet UILabel *incomeNumber;

@property (nonatomic,strong)UserModel *model;

@end
