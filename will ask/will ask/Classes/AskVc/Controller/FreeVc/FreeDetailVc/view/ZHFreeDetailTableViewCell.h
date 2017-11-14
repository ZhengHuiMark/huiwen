//
//  ZHFreeDetailTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/10/31.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHFreeDetailModel;

@interface ZHFreeDetailTableViewCell : UITableViewCell

@property(nonatomic,strong)ZHFreeDetailModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImg;

@property (weak, nonatomic) IBOutlet UILabel *userNickName;

@property (weak, nonatomic) IBOutlet UILabel *ExpertName;

@property (weak, nonatomic) IBOutlet UIImageView *AskImg;

@property (weak, nonatomic) IBOutlet UILabel *contentL;

@property (weak, nonatomic) IBOutlet UIImageView *typeImage;

@property (weak, nonatomic) IBOutlet UILabel *browseNumber;

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ContentImageView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *imageButtons;

@end
