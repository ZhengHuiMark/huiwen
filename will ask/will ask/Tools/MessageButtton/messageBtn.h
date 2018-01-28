//
//  messageBtn.h
//  will ask
//
//  Created by 郑晖 on 2018/1/27.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface messageBtn : UIButton

@property (nonatomic, copy) void(^MessBtnClickBlock)();

@end
