//
//  ZHExitAccountTableViewCell.h
//  will ask
//
//  Created by 郑晖 on 2018/1/2.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^exitActionDidClick)();


@interface ZHExitAccountTableViewCell : UITableViewCell


@property(nonatomic,copy)exitActionDidClick didClick;


@end
