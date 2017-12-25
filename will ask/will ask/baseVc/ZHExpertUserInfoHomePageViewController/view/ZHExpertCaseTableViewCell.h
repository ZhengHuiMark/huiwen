//
//  ZHExpertCaseTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHExpertUserInfoCaseModel;

@interface ZHExpertCaseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *typeCaseImg;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordsNumber;
@property (weak, nonatomic) IBOutlet UILabel *TimeRead;
@property (weak, nonatomic) IBOutlet UILabel *releasePerson;
@property (weak, nonatomic) IBOutlet UILabel *releaseTime;
@property (weak, nonatomic) IBOutlet UILabel *caseContent;
@property (weak, nonatomic) IBOutlet UILabel *clickNumber;
@property (weak, nonatomic) IBOutlet UILabel *moneyNumber;
@property (weak, nonatomic) IBOutlet UILabel *contentWords;
@property (weak, nonatomic) IBOutlet UILabel *salesNumber;

@property(nonatomic,strong) ZHExpertUserInfoCaseModel *caseModel;

@end
