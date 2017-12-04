//
//  ZHRewardAndDateTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/10/12.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardAndDateTableViewCell.h"
#import "ZHAskQuestionTableViewControllerHeader.h"
#import "ZHRewardMoneyViewController.h"
#import "ZHAskQuestionTableViewController.h"
#import "ZHAskQuestionModel.h"

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
            
//            self.RewardNumberL.text = self.tete.label123;

        }
            break;
        case kValidationViewControllerRow_RewardData:{
            self.RewardLabel.text = @"悬赏时间:";
//            self.RewardNumberL.text = 
        }
            
        default:
            break;
    }
}

- (void)setModel:(ZHAskQuestionModel *)model{
    
    _model = model;
    
    
    switch (self.indexPath.row) {
        case kValidationViewControllerRow_RewardMoney:{
            self.RewardNumberL.text = self.model.amount;
            
        }
            
            break;
        case kValidationViewControllerRow_RewardData:{
            
            self.RewardNumberL.text = self.model.timeLimit;
            NSLog(@"model = %p",self.model.timeLimit);

        }
            break;
            
        default:
            break;
    }
    
}





@end
