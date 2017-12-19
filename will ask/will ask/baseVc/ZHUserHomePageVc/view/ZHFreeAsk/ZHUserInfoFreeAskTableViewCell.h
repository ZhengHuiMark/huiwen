//
//  ZHUserInfoFreeAskTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHUserInfoFreeModel;

@interface ZHUserInfoFreeAskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *readNum;
@property (weak, nonatomic) IBOutlet UILabel *ansNumber;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property(nonatomic, strong)ZHUserInfoFreeModel *freeModel;

@end
