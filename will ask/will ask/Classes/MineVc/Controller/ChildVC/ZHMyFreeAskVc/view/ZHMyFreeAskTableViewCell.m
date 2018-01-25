//
//  ZHMyFreeAskTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/7.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMyFreeAskTableViewCell.h"
#import "ZHMyFreeAskModel.h"
#import "Macro.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"

@implementation ZHMyFreeAskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ZHMyFreeAskModel *)model{
    
    _model = model;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.model.avatar]]];
    
    self.userName.text = self.model.nickname;
    
    self.expertName.text = self.model.certifiedNames;
    
    self.time.text = self.model.time;
    
    self.contentLabel.text = self.model.content;
    
    self.readNumber.text = self.model.readNumber;
    
    self.answerNumber.text = self.model.answerNumber;
    
    
    
}

- (IBAction)editorFreeAskAction:(UIButton *)sender {
    
    !self.editDidClick?:self.editDidClick();

}


- (IBAction)deleteFreeAskAction:(UIButton *)sender {
    
    !self.didClick?:self.didClick();
    
}

@end
