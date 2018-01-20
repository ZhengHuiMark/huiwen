//
//  ZHGoodAtBusinessVC.h
//  will ask
//
//  Created by yangxudong on 2018/1/14.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHGoodAtBusinessVC : UIViewController
@property (nonatomic, copy) void((^SaveSedBusiessBlock)(NSString *busiessStr));
@end
