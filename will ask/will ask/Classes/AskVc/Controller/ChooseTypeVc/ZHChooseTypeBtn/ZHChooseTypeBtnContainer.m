//
//  ZHBtnContainer.m
//  demoReward
//
//  Created by 郑晖 on 2017/10/11.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHChooseTypeBtnContainer.h"
#import "ZHChooseTypeBtnModel.h"
#import "ZHChooseTypeSubTagModel.h"

@implementation ZHChooseTypeBtnContainer



#pragma mark - Override Setter/Getter Methods
- (CGFloat)cellHeight {
 
    
    for (ZHChooseTypeBtnModel *tagModel in self.tagModels) {
        if (tagModel.isSelected) {
            ZHChooseTypeBtnModel *subTagModel = (ZHChooseTypeBtnModel *)[tagModel.subTags lastObject];
            if (!subTagModel) continue;
            return CGRectGetMaxY(subTagModel.frame) + [ZHChooseTypeSubTagModel marginBottom];
        }
    }
    
    return [ZHChooseTypeBtnModel marginTop] + [ZHChooseTypeBtnModel marginBottom] + [ZHChooseTypeBtnModel btnHeight];}

@end
