//
//  ZHLearnToMeTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/10.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHLearnToMeModel;
@interface ZHLearnToMeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userAvtar;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *cerTitle;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (nonatomic,strong)ZHLearnToMeModel *model;

@end
