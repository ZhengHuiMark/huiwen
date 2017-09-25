//
//  ZHEditTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/9/21.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserInfoModel;

typedef void(^UserInfoCellDidClick)(NSIndexPath *indexPath);

typedef void(^DateInfoCellDidClick)(NSIndexPath *indexPath);

@interface ZHEditTableViewCell : UITableViewCell

@property (nonatomic, strong) UserInfoModel *UserInfoModel;


@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (weak, nonatomic) IBOutlet UITextField *NameTextF;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) UserInfoCellDidClick didClick;

@property (nonatomic, copy) DateInfoCellDidClick DateClick;



@end
