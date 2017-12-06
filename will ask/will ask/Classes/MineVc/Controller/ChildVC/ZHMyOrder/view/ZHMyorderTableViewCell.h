//
//  ZHMyorderTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/6.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHMyOrderModel;

typedef NS_ENUM(NSUInteger, ReviewStatus) {
    ReviewStatusWaitPayFor,
    ReviewStatusCancel,
    ReviewStatusSuccess,
};

@interface ZHMyorderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *TypeName;

@property (weak, nonatomic) IBOutlet UILabel *PayStatus;

@property (weak, nonatomic) IBOutlet UILabel *titleL;

@property (weak, nonatomic) IBOutlet UILabel *money;

@property (weak, nonatomic) IBOutlet UILabel *generateTimeL;

@property (weak, nonatomic) IBOutlet UILabel *closeTime;

@property (weak, nonatomic) IBOutlet UILabel *orderDetailL;

@property (weak, nonatomic) IBOutlet UIButton *payForBtn;

@property (weak, nonatomic) IBOutlet UILabel *payLabel;

@property (weak, nonatomic) ZHMyOrderModel *orderModel;

@property (nonatomic, assign) ReviewStatus status;

@end
