//
//  ZHMyCardNumberTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHVipCardModel;

typedef void(^invoiceBtnDidClick)(void);
typedef void(^recordBtnDidClick)(void);



@interface ZHMyCardNumberTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *CardNumber;

@property(nonatomic,strong)ZHVipCardModel *model;

@property(nonatomic,copy) recordBtnDidClick recordBtnClick;

@property(nonatomic,copy) invoiceBtnDidClick invoiceBtnClick;


@end
