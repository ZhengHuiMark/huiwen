//
//  ZHHeaderTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/9/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *touXiangBtn;
@property (weak, nonatomic) IBOutlet UILabel *userIDLabel;
@property (weak, nonatomic) IBOutlet UIView *placeholderView;

@end
