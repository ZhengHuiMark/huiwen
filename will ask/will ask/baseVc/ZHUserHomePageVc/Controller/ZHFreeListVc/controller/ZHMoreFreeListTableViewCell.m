//
//  ZHMoreFreeListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/20.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMoreFreeListTableViewCell.h"
#import "ZHMoreFreeListModel.h"
#import "ImageTools.h"


@implementation ZHMoreFreeListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
//    frame.size.width -= 20;
    [super setFrame:frame];
}

-(void)setModel:(ZHMoreFreeListModel *)model{
    _model = model;
    
    self.time.text = self.model.time;
    
    self.userName.text = self.model.nickname;
    
    self.content.text = self.model.content;
    
    self.replyNum.text = self.model.answerNumber;
    
    self.readNumber.text  =  self.model.readNumber;
    
    
}
@end
