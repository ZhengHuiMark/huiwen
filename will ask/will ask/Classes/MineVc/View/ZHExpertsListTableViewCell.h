//
//  ZHExpertsListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/9/15.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^focusDidClick)();
typedef void(^incomeDidClick)();
typedef void(^newConultDidClick)();

@class UserModel;
@interface ZHExpertsListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *foucsMeLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeNumber;
@property (weak, nonatomic) IBOutlet UILabel *NewConsultingNumber;

@property(nonatomic,strong) UserModel *userModel;

@property(nonatomic,copy)focusDidClick didClick;

@property(nonatomic,copy)incomeDidClick incomeDidClick;

@property(nonatomic,copy)newConultDidClick newConultDidClick;


@end
