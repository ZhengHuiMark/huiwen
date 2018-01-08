//
//  ZHMoneyTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/9/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;

typedef void(^cardBtnDidClick)();
typedef void(^myWalletBtnDidClick)();

@interface ZHMoneyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *memberCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;

@property (strong, nonatomic) UserModel *usermodel;

@property (nonatomic,copy) cardBtnDidClick cardClick;

@property (nonatomic,copy) myWalletBtnDidClick walletClick;


@end
