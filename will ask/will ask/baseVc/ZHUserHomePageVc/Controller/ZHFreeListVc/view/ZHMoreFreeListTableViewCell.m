//
//  ZHMoreFreeListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/12/25.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHMoreFreeListTableViewCell.h"
#import "ZHMoerFreeListModel.h"
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



- (void)setModel:(ZHMoerFreeListModel *)model{
    
    _model = model;
    
    self.time.text = self.model.time;
    
    self.userName.text = self.model.nickname;
    
    self.content.text = self.model.content;
    
    self.replyNum.text = self.model.answerNumber;
    
    self.readNumber.text  =  self.model.readNumber;
    
    
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

@end
