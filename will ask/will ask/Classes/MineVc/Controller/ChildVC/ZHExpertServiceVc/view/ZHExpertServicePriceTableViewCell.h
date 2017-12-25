//
//  ZHExpertServicePriceTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PriceCellDidClick)();

@class ZHExpertServiceListModel;
@interface ZHExpertServicePriceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *priceTextFiled;

@property (nonatomic,strong)ZHExpertServiceListModel *priceModel;

@property(nonatomic,copy) PriceCellDidClick didClick;

@end
