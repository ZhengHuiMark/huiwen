//
//  ZHUserInfoFreeAskTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/19.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHUserInfoFreeAskTableViewCell.h"
#import "ZHUserInfoFreeModel.h"


@implementation ZHUserInfoFreeAskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFreeModel:(ZHUserInfoFreeModel *)freeModel{
    _freeModel = freeModel;
    
    self.contentLabel.text = self.freeModel.content;
    self.readNum.text = self.freeModel.readNumber;
    self.ansNumber.text = self.freeModel.answerNumber;
    
    self.time.text = self.freeModel.time;
    

}

@end
