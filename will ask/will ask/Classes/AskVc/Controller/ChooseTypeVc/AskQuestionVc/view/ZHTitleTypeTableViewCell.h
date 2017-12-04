//
//  ZHTitleTypeTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHTitleTypeTableViewCell : UITableViewCell
// 大分类
@property (weak, nonatomic) IBOutlet UILabel *titleType;
// 小分类
@property (weak, nonatomic) IBOutlet UILabel *titleSubType;

@end
