//
//  ZHFreeListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/9/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHFreeListTableViewCell.h"
#import "ZHAskModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"


@implementation ZHFreeListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(ZHAskModel *)model {
    _model = model;
    
//    self.userAvatarImg = model.avatar;
    [self.userAvatarImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUser,OSS,model.avatar]]];
    
    self.userNickNameL.text = model.nickname;
    self.expertsTitleL.text = model.certifiedNames;
    self.releaseTimeL.text = model.time;
    self.contentLabel.text = model.content;
    
    [self.seeBtn setImage:[UIImage imageNamed:@"read"] forState:UIControlStateNormal];
    [self.commentsBtn setImage:[UIImage imageNamed:@"reply"] forState:UIControlStateNormal];

    [self.seeBtn setTitle:model.readNumber forState:UIControlStateNormal];
    [self.commentsBtn setTitle:model.answerNumber forState:UIControlStateNormal];
 
    if ([model.type  isEqual: @"审计"]) {
            [self.typeImg setImage:[UIImage imageNamed:@"shenji"]];
    }else if ([model.type isEqual:@"税务"]){
        [self.typeImg setImage:[UIImage imageNamed:@"shuiwu"]];

    }else if  ([model.type isEqual:@"软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"ruanjian"]];
        
    }else if  ([model.type isEqual:@"评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"pinggu"]];
        
    }else if  ([model.type isEqual:@"会计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }


}

@end


//
//@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImg;
//@property (weak, nonatomic) IBOutlet UILabel *userNickNameL;
//@property (weak, nonatomic) IBOutlet UILabel *expertsTitleL;
//@property (weak, nonatomic) IBOutlet UILabel *releaseTimeL;
//@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
//@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//@property (weak, nonatomic) IBOutlet UIButton *seeBtn;
//@property (weak, nonatomic) IBOutlet UIButton *commentsBtn;

