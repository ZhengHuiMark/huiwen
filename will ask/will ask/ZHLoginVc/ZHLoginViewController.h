//
//  ZHLoginViewController.h
//  will ask
//
//  Created by 郑晖 on 2017/9/5.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZHLoginCompletion)(BOOL isLoginSucess);

@interface ZHLoginViewController : UIViewController

@property (nonatomic, copy) ZHLoginCompletion loginCompletion;


@end
