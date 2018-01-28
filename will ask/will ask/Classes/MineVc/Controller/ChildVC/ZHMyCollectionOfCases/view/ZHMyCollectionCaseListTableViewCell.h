//
//  ZHMyCollectionCaseListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/25.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cancelDidClick)();
typedef void(^continueDidClick)();
@class ZHCaseListsModel;
@interface ZHMyCollectionCaseListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *words;
@property (weak, nonatomic) IBOutlet UILabel *remingTime;
@property (weak, nonatomic) IBOutlet UILabel *creatTime;
@property (weak, nonatomic) IBOutlet UILabel *releasePeople;

@property(nonatomic,strong)ZHCaseListsModel *model;


@property (nonatomic, copy) continueDidClick continueDidClick;

@property (nonatomic, copy) cancelDidClick cancelDidClick;




@end
