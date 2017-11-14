//
//  ZHRewardAndDateTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardAndDateTableViewCell.h"
#import "ZHAskQuestionTableViewControllerHeader.h"

@implementation ZHRewardAndDateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    
    switch (indexPath.row) {
        case kValidationViewControllerRow_RewardMoney:{
            self.RewardLabel.text = @"悬赏赏金:";
        }
            break;
        case kValidationViewControllerRow_RewardData:{
            self.RewardLabel.text = @"悬赏时间:";
        }
            
        default:
            break;
    }
}







@end
