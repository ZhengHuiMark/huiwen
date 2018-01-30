//
//  ZHCaseListTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/28.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHCaseListTableViewCell.h"
#import "ZHCaseListsModel.h"
#import "ZHAllModel.h"
#import "ZHMoreCaseListModel.h"

@implementation ZHCaseListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(ZHCaseListsModel *)model{
    _model = model;
    
    self.contentLabel.text = self.model.title;
    
//    [self.ExpertBtn setTitle:[NSString stringWithFormat:@"查看专家详解版(%@)",self.model.analysisNumber] forState:UIControlStateNormal];
    
    self.wordsLabel.text = [NSString stringWithFormat:@"字数: %@",self.model.words];
    
    self.readTime.text = [NSString stringWithFormat:@"预计阅读时间: %@",self.model.readingTime];
    
//    self.releaseL.text = self.model.
    self.releaseTime.text = [NSString stringWithFormat:@"发布时间: %@",self.model.createTime];
    
    self.releaseL.text = @"发布人: 会问";
    
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

-(void)setAllModel:(ZHAllModel *)allModel{
    _allModel = allModel;
    
    self.contentLabel.text = self.allModel.title;
    
    //    [self.ExpertBtn setTitle:[NSString stringWithFormat:@"查看专家详解版(%@)",self.model.analysisNumber] forState:UIControlStateNormal];
    
    self.wordsLabel.text = [NSString stringWithFormat:@"字数: %@",self.allModel.words];
    
    self.readTime.text = [NSString stringWithFormat:@"预计阅读时间: %@",self.allModel.readingTime];
    
    //    self.releaseL.text = self.model.
    self.releaseTime.text = [NSString stringWithFormat:@"发布时间: %@",self.allModel.createTime];
    
    self.releaseL.text = @"发布人: 会问";
    
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

- (void)setMoreCaseModel:(ZHMoreCaseListModel *)moreCaseModel{
    _moreCaseModel = moreCaseModel;
    

    self.contentLabel.text = self.moreCaseModel.title;
    
    //    [self.ExpertBtn setTitle:[NSString stringWithFormat:@"查看专家详解版(%@)",self.model.analysisNumber] forState:UIControlStateNormal];
    
    self.wordsLabel.text = [NSString stringWithFormat:@"字数: %@",self.moreCaseModel.caseWords];
    
    self.readTime.text = [NSString stringWithFormat:@"预计阅读时间: %@",self.moreCaseModel.readingTime];
    
    //    self.releaseL.text = self.model.
    self.releaseTime.text = [NSString stringWithFormat:@"发布时间: %@",self.moreCaseModel.createTime];
    
    self.releaseL.text = @"发布人: 会问";
    
    if ([moreCaseModel.type  isEqual: @"涉税实务"]) {
        [self.typeImg setImage:[UIImage imageNamed:@"sssw"]];
    }else if ([moreCaseModel.type isEqual:@"税收优惠"]){
        [self.typeImg setImage:[UIImage imageNamed:@"ssyh"]];
        
    }else if  ([moreCaseModel.type isEqual:@"发票管理"]){
        [self.typeImg setImage:[UIImage imageNamed:@"fpgl"]];
        
    }else if  ([moreCaseModel.type isEqual:@"税收筹划"]){
        [self.typeImg setImage:[UIImage imageNamed:@"ssch"]];
        
    }else if  ([moreCaseModel.type isEqual:@"纳税申报"]){
        [self.typeImg setImage:[UIImage imageNamed:@"nssb"]];
        
    }else if  ([moreCaseModel.type isEqual:@"跨境税收"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kjss"]];
        
    }else if  ([moreCaseModel.type isEqual:@"税务其他"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtsw"]];
        
    }else if  ([moreCaseModel.type isEqual:@"年报审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"nbsj"]];
        
    }else if  ([moreCaseModel.type isEqual:@"上市审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"sssj"]];
        
    }else if  ([moreCaseModel.type isEqual:@"债券审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"zqsj"]];
        
    }else if  ([moreCaseModel.type isEqual:@"验资审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"yzsj"]];
        
    }else if  ([moreCaseModel.type isEqual:@"内容审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"nksj"]];
        
    }else if  ([moreCaseModel.type isEqual:@"其他审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtsj"]];
        
    }else if  ([moreCaseModel.type isEqual:@"会计核算"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kjhs"]];
        
    }else if  ([moreCaseModel.type isEqual:@"政策咨询"]){
        [self.typeImg setImage:[UIImage imageNamed:@"zczx"]];
        
    }else if  ([moreCaseModel.type isEqual:@"财务管理"]){
        [self.typeImg setImage:[UIImage imageNamed:@"cwgl"]];
        
    }else if  ([moreCaseModel.type isEqual:@"报表编制"]){
        [self.typeImg setImage:[UIImage imageNamed:@"bbbz"]];
        
    }else if  ([moreCaseModel.type isEqual:@"会计其他"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtkj"]];
        
    }else if  ([moreCaseModel.type isEqual:@"资产评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([moreCaseModel.type isEqual:@"单项评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([moreCaseModel.type isEqual:@"整体评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([moreCaseModel.type isEqual:@"价值评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([moreCaseModel.type isEqual:@"其他评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([moreCaseModel.type isEqual:@"财务软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"cwrj"]];
        
    }else if  ([moreCaseModel.type isEqual:@"审计软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"sjrj"]];
        
    }else if  ([moreCaseModel.type isEqual:@"office软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"office"]];
        
    }else if  ([moreCaseModel.type isEqual:@"其他软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtrj"]];
        
    }

}



@end
