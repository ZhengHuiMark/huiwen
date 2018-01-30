//
//  ZHCaseListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/11/28.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHCaseListsModel,ZHAllModel,ZHMoreCaseListModel;

@interface ZHCaseListTableViewCell : UITableViewCell

@property(nonatomic,strong)ZHCaseListsModel *model;
@property (nonatomic, strong) ZHAllModel *allModel;

@property (weak, nonatomic) IBOutlet UIImageView *typeImg;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *ExpertBtn;

@property (weak, nonatomic) IBOutlet UILabel *wordsLabel;

@property (weak, nonatomic) IBOutlet UILabel *readTime;

@property (weak, nonatomic) IBOutlet UILabel *releaseL;

@property (weak, nonatomic) IBOutlet UILabel *releaseTime;


@property (nonatomic, strong) ZHMoreCaseListModel *moreCaseModel;
@end
