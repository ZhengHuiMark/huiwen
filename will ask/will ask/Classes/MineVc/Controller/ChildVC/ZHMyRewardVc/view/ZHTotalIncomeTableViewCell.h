//
//  ZHTotalIncomeTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/4.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHTotalIncomeModel;
@interface ZHTotalIncomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalIncome;

@property(nonatomic,strong)ZHTotalIncomeModel *totalIncomeModel;

@end
