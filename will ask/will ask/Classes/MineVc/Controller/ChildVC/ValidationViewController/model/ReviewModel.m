//
//  ReviewModel.m
//  XXXXXXX
//
//  Created by 郑晖 on 2017/10/14.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ReviewModel.h"

@implementation ReviewModel

- (CGFloat)cellHeight {
    
    switch (self.status) {
        case ReviewStatusNormal: {
            return 0;
        }
            break;
            
        case ReviewStatusSelected: {
            return 160;
        }
            break;
            
        case ReviewStatusSuccess: {
            return 0;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

@end
