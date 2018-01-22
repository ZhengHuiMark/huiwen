//
//  ZHMyFocusListTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/12/18.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHMyFocusModel;

typedef void(^cancelDidClick)();
typedef void(^ImmediatelyConsultDidClick)();
@interface ZHMyFocusListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *hoor;
@property (weak, nonatomic) IBOutlet UILabel *cerTitle;
@property (nonatomic,strong)ZHMyFocusModel *model;

@property(nonatomic,copy)cancelDidClick didClick;

@property(nonatomic,copy)ImmediatelyConsultDidClick consultDidClick;



@end
