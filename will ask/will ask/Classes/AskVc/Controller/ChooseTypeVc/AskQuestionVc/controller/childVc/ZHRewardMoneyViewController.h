//
//  ZHRewardMoneyViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnValueBlock) (NSString *strValue);


@interface ZHRewardMoneyViewController : UIViewController

/**
 *  声明一个ReturnValueBlock属性，这个Block是获取传值的界面传进来的
 */
@property(nonatomic, copy) ReturnValueBlock returnValueBlock;



@end
