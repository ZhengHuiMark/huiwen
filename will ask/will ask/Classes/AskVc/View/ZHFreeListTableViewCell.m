//
//  ZHFreeListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/9/27.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHFreeListTableViewCell.h"
#import "ZHAskModel.h"
#import "ZHAllModel.h"
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
    [self.userAvatarImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,model.avatar]]];
    
    self.userNickNameL.text = model.nickname;
    self.expertsTitleL.text = model.certifiedNames;
    self.releaseTimeL.text = model.time;
    self.contentLabel.text = model.content;
    
    [self.seeBtn setImage:[UIImage imageNamed:@"read"] forState:UIControlStateNormal];
    [self.commentsBtn setImage:[UIImage imageNamed:@"reply"] forState:UIControlStateNormal];

    [self.seeBtn setTitle:model.readNumber forState:UIControlStateNormal];
    [self.commentsBtn setTitle:model.answerNumber forState:UIControlStateNormal];
 
    if ([model.type  isEqual: @"涉税实务"]) {
            [self.typeImg setImage:[UIImage imageNamed:@"sssw"]];
    }else if ([model.type isEqual:@"税收优惠"]){
        [self.typeImg setImage:[UIImage imageNamed:@"ssyh"]];

    }else if  ([model.type isEqual:@"发票管理"]){
        [self.typeImg setImage:[UIImage imageNamed:@"fpgl"]];
        
    }else if  ([model.type isEqual:@"税收筹划"]){
        [self.typeImg setImage:[UIImage imageNamed:@"ssch"]];
        
    }else if  ([model.type isEqual:@"纳税申报"]){
        [self.typeImg setImage:[UIImage imageNamed:@"nssb"]];
        
    }else if  ([model.type isEqual:@"跨境税收"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kjss"]];
        
    }else if  ([model.type isEqual:@"税务其他"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtsw"]];
        
    }else if  ([model.type isEqual:@"年报审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"nbsj"]];
        
    }else if  ([model.type isEqual:@"上市审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"sssj"]];
        
    }else if  ([model.type isEqual:@"债券审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"zqsj"]];
        
    }else if  ([model.type isEqual:@"验资审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"yzsj"]];
        
    }else if  ([model.type isEqual:@"内容审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"nksj"]];
        
    }else if  ([model.type isEqual:@"其他审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtsj"]];
        
    }else if  ([model.type isEqual:@"会计核算"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kjhs"]];
        
    }else if  ([model.type isEqual:@"政策咨询"]){
        [self.typeImg setImage:[UIImage imageNamed:@"zczx"]];
        
    }else if  ([model.type isEqual:@"财务管理"]){
        [self.typeImg setImage:[UIImage imageNamed:@"cwgl"]];
        
    }else if  ([model.type isEqual:@"报表编制"]){
        [self.typeImg setImage:[UIImage imageNamed:@"bbbz"]];
        
    }else if  ([model.type isEqual:@"会计其他"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtkj"]];
        
    }else if  ([model.type isEqual:@"资产评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([model.type isEqual:@"单项评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([model.type isEqual:@"整体评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([model.type isEqual:@"价值评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([model.type isEqual:@"其他评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([model.type isEqual:@"财务软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"cwrj"]];
        
    }else if  ([model.type isEqual:@"审计软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"sjrj"]];
        
    }else if  ([model.type isEqual:@"office软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"office"]];
        
    }else if  ([model.type isEqual:@"其他软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtrj"]];
        
    }

}

- (void)setAllModel:(ZHAllModel *)allModel{
    _allModel = allModel;
    
    
    //    self.userAvatarImg = model.avatar;
    [self.userAvatarImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,allModel.avatar]]];
    
    self.userNickNameL.text = allModel.nickname;
    self.expertsTitleL.text = allModel.certifiedNames;
    self.releaseTimeL.text = allModel.time;
    self.contentLabel.text = allModel.content;
    
    [self.seeBtn setImage:[UIImage imageNamed:@"read"] forState:UIControlStateNormal];
    [self.commentsBtn setImage:[UIImage imageNamed:@"reply"] forState:UIControlStateNormal];
    
    [self.seeBtn setTitle:allModel.readNumber forState:UIControlStateNormal];
    [self.commentsBtn setTitle:allModel.answerNumber forState:UIControlStateNormal];
    
    if ([allModel.type  isEqual: @"涉税实务"]) {
        [self.typeImg setImage:[UIImage imageNamed:@"sssw"]];
    }else if ([allModel.type isEqual:@"税收优惠"]){
        [self.typeImg setImage:[UIImage imageNamed:@"ssyh"]];
        
    }else if  ([allModel.type isEqual:@"发票管理"]){
        [self.typeImg setImage:[UIImage imageNamed:@"fpgl"]];
        
    }else if  ([allModel.type isEqual:@"税收筹划"]){
        [self.typeImg setImage:[UIImage imageNamed:@"ssch"]];
        
    }else if  ([allModel.type isEqual:@"纳税申报"]){
        [self.typeImg setImage:[UIImage imageNamed:@"nssb"]];
        
    }else if  ([allModel.type isEqual:@"跨境税收"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kjss"]];
        
    }else if  ([allModel.type isEqual:@"税务其他"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtsw"]];
        
    }else if  ([allModel.type isEqual:@"年报审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"nbsj"]];
        
    }else if  ([allModel.type isEqual:@"上市审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"sssj"]];
        
    }else if  ([allModel.type isEqual:@"债券审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"zqsj"]];
        
    }else if  ([allModel.type isEqual:@"验资审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"yzsj"]];
        
    }else if  ([allModel.type isEqual:@"内容审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"nksj"]];
        
    }else if  ([allModel.type isEqual:@"其他审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtsj"]];
        
    }else if  ([allModel.type isEqual:@"会计核算"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kjhs"]];
        
    }else if  ([allModel.type isEqual:@"政策咨询"]){
        [self.typeImg setImage:[UIImage imageNamed:@"zczx"]];
        
    }else if  ([allModel.type isEqual:@"财务管理"]){
        [self.typeImg setImage:[UIImage imageNamed:@"cwgl"]];
        
    }else if  ([allModel.type isEqual:@"报表编制"]){
        [self.typeImg setImage:[UIImage imageNamed:@"bbbz"]];
        
    }else if  ([allModel.type isEqual:@"会计其他"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtkj"]];
        
    }else if  ([allModel.type isEqual:@"资产评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([allModel.type isEqual:@"单项评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([allModel.type isEqual:@"整体评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([allModel.type isEqual:@"价值评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([allModel.type isEqual:@"其他评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([allModel.type isEqual:@"财务软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"cwrj"]];
        
    }else if  ([allModel.type isEqual:@"审计软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"sjrj"]];
        
    }else if  ([allModel.type isEqual:@"office软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"office"]];
        
    }else if  ([allModel.type isEqual:@"其他软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtrj"]];
        
    }
    
    
}

- (IBAction)btnUserInfo:(UIButton *)sender {
    
    !self.didClick?:self.didClick();
    
}


@end



