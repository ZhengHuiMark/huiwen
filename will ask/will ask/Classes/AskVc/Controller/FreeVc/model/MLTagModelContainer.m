//
//  MLTagModelContainer.m
//  xxxx
//
//  Created by CristianoRLong on 07/10/2017.
//  Copyright © 2017 CristianoRLong. All rights reserved.
//

#import "MLTagModelContainer.h"
#import "MLTagModel.h"
#import "MLSubTagModel.h"

@implementation MLTagModelContainer
#pragma mark - Override Setter/Getter Methods
- (CGFloat)cellHeight {
    
    for (MLTagModel *tagModel in self.tagModels) {
        if (tagModel.isSelected) {
            MLTagModel *subTagModel = (MLTagModel *)[tagModel.subTags lastObject];
            if (!subTagModel) continue;
            return CGRectGetMaxY(subTagModel.frame) + [MLSubTagModel marginBottom];
        }
    }
    
    return [MLTagModel marginTop] + [MLTagModel marginBottom] + [MLTagModel btnHeight];
}



@end
