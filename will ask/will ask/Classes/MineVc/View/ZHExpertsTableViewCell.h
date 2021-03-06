//
//  ZHExpertsTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/9/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didClick)();

@interface ZHExpertsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *expertsBtn;

@property (nonatomic, copy) didClick BtnClick;

@end
