//
//  ZHAskQuestionTableViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHAskQuestionTableViewController : UITableViewController
// 选择界面传过来的大分类
@property(nonatomic,copy)NSString *titleTypeLabel;
// 选择界面传过来的小分类
@property(nonatomic,copy)NSString *titleSubTypeLabel;

@property(nonatomic,copy)NSString *CodeSubType;


/** 选择界面传过来的类型 1 免费问 2 悬赏问 3 免费问回显页面 */
@property(nonatomic,copy)NSString *AskType;
/** 从编辑界面传过来的免费问ID */
@property (nonatomic,copy)NSString *editId;

@property (nonatomic,copy) NSString *label123;


@end
