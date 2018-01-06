//
//  ZHCaseBreakDownTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/11/8.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHCaseModel;

@interface ZHCaseBreakDownTableViewCell : UITableViewCell

/** 案例类型  */
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;

/** 标题  */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/** 内容  */
//@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

/** 字数  */
@property (weak, nonatomic) IBOutlet UILabel *numberOfWords;

/** 预计阅读时间  */
@property (weak, nonatomic) IBOutlet UILabel *time;

@property(strong,nonatomic) ZHCaseModel *model;

@end
