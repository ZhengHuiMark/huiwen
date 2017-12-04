//
//  ZHReleaseTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ZHreleaseBtnClick)();

@interface ZHReleaseTableViewCell : UITableViewCell

@property(nonatomic,copy)ZHreleaseBtnClick releaseBtnClick;

@end
