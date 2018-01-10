//
//  ZHExpertServiceListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHExpertServiceListTableViewCell.h"
#import "ZHExpertServiceListModel.h"

@implementation ZHExpertServiceListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setExpertServiceModel:(ZHExpertServiceListModel *)expertServiceModel{
    _expertServiceModel = expertServiceModel;
    
    switch (self.indexPath.row) {
        case 0:{
            self.variableLabel.text =self.expertServiceModel.consultWaitNumber;
        }
            break;
//        case 1:{
//            self.variableLabel.hidden = YES;
//        }
            break;
        case 1:{
            self.variableLabel.text = self.expertServiceModel.rewardAnswerIncome;

        }
            break;
        case 2:{
            self.variableLabel.hidden = YES;
        }
            break;
        case 3:{
            self.variableLabel.text = self.expertServiceModel.rewardLearningIncome;
        }
            break;
        case 4:{
            self.variableLabel.hidden = YES;

        }
            break;
            
            
        default:
            break;
    }
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    switch (indexPath.row) {
        case 0:{
            self.titleLabel.text = @"咨询我的问题";
            self.arrowLabel.text = @">";
            self.detailedLabel.text = @"待回答";
        }
            break;
//        case 1:{
//            self.titleLabel.text = @"我的案例详解";
//            self.arrowLabel.text = @">";
//
//            self.detailedLabel.hidden = YES;
//        }
            break;
        case 1:{
            self.titleLabel.text = @"我的悬赏抢答";
            self.arrowLabel.text = @">";

            self.detailedLabel.text = @"昨日新增收入";

        }
            break;
        case 2:{
            self.titleLabel.text = @"关注我的用户";
            self.arrowLabel.text = @">";

            self.detailedLabel.hidden = YES;
        }
            break;
        case 3:{
            self.titleLabel.text = @"想我学习的用户";
            self.arrowLabel.text = @">";

            self.detailedLabel.text = @"昨日新增收入";

        }
            break;
        case 4:{
            self.titleLabel.text = @"提问时身份";
            self.arrowLabel.text = @">";

            self.detailedLabel.text = @"当前提问使用普通用户";

        }
            break;
            
        default:
            break;
    }
    
}

@end
