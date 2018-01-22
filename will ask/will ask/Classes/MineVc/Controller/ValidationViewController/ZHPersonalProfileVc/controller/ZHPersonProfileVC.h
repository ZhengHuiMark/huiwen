//
//  ZHPersonProfileVC.h
//  will ask
//
//  Created by 郑晖 on 2018/1/21.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHPersonProfileVC : UIViewController
@property (nonatomic, copy) void((^SavePersonProfileBlock)(NSString *string));
@end
