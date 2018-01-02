//
//  ZHExpertUserInfoCaseTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHExpertCaseModel;

@interface ZHExpertUserInfoCaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *titleContent;
@property (weak, nonatomic) IBOutlet UILabel *wordNumber;
@property (weak, nonatomic) IBOutlet UILabel *readTime;
@property (weak, nonatomic) IBOutlet UILabel *releaseTime;
@property (weak, nonatomic) IBOutlet UILabel *caseContent;
@property (weak, nonatomic) IBOutlet UILabel *clickNumber;
@property (weak, nonatomic) IBOutlet UILabel *priceNumber;
@property (weak, nonatomic) IBOutlet UILabel *contentWords;
@property (weak, nonatomic) IBOutlet UILabel *salesNumber;

@property(nonatomic,strong)ZHExpertCaseModel *caseModel;

@end
