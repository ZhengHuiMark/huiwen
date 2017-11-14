//
//  ZHTypeTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2017/11/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FindExpertDidClick)(void);

typedef void(^CheckCaseDidClick) (void);

@interface ZHTypeTableViewCell : UITableViewCell



@property(nonatomic,copy) FindExpertDidClick didClick;


@property(nonatomic,copy) CheckCaseDidClick CaseDidClick;

@end
