//
//  ZHBtnContainer.m
//  demoReward
//
//  Created by 郑晖 on 2017/10/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHBtnContainer.h"
#import "ZHBtnModel.h"

@implementation ZHBtnContainer



#pragma mark - Override Setter/Getter Methods
- (CGFloat)cellHeight {
 
    
    return [ZHBtnModel marginTop] + [ZHBtnModel marginBottom] + [ZHBtnModel btnHeight];
}

@end
