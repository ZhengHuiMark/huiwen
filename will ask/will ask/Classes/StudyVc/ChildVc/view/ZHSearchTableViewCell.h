//
//  ZHSearchTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/11/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^screeningDidClick)(UIButton *sender);
typedef void(^searchDidClick)();

@interface ZHSearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *screeningBtn;
@property (weak, nonatomic) IBOutlet UIImageView *lineImgView;

@property(nonatomic,copy)screeningDidClick didClick;
@property (nonatomic, copy) searchDidClick searchClick;

@end
