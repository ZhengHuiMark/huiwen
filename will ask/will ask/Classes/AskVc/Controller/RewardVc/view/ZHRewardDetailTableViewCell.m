//
//  ZHRewardDetailTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardDetailTableViewCell.h"
#import "ZHFreeDetailModel.h"
#import "ZHFreeAnswerModel.h"
#import "Macro.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"
#import "MLAvatarDisplayView.h"



@interface ZHRewardDetailTableViewCell()

@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end

@implementation ZHRewardDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetailModel:(ZHFreeDetailModel *)detailModel {
    _detailModel = detailModel;
    
   
    self.userNickName.text = self.detailModel.nickname;
    
    [self.userAvatarImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.detailModel.avatar]]];
    
    self.content.text = [NSString stringWithFormat:@"      %@",self.detailModel.content];
    
    NSString *wenzi = self.detailModel.content;
    CGFloat marin = 17.5;
    CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - marin * 2;
    CGFloat labelHeight = [wenzi boundingRectWithSize: CGSizeMake(labelWidth, 300)
                                              options: NSStringDrawingUsesLineFragmentOrigin
                                           attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 14]}
                                              context: nil].size.height;
    [self.content mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(labelHeight);
    }];
    
    
    if (!self.detailModel.certifiedNames) {
        self.expertName.text = @"  ";
    }else{
    self.expertName.text = self.detailModel.certifiedNames;
    }
    
    
    self.remainingTime.text = [NSString stringWithFormat:@"剩余回答时间:%@",self.detailModel.remainingTime];

    self.rewardMoney.text = [NSString stringWithFormat:@"￥%@",self.detailModel.amount];
    self.rewardMoney.layer.cornerRadius = 10;
    
    self.rewardMoney.clipsToBounds = YES;
    
    if ([self.detailModel.type  isEqual: @"涉税实务"]) {
        [self.typeImg setImage:[UIImage imageNamed:@"sssw"]];
    }else if ([self.detailModel.type isEqual:@"税收优惠"]){
        [self.typeImg setImage:[UIImage imageNamed:@"ssyh"]];
        
    }else if  ([self.detailModel.type isEqual:@"发票管理"]){
        [self.typeImg setImage:[UIImage imageNamed:@"fpgl"]];
        
    }else if  ([self.detailModel.type isEqual:@"税收筹划"]){
        [self.typeImg setImage:[UIImage imageNamed:@"ssch"]];
        
    }else if  ([self.detailModel.type isEqual:@"纳税申报"]){
        [self.typeImg setImage:[UIImage imageNamed:@"nssb"]];
        
    }else if  ([self.detailModel.type isEqual:@"跨境税收"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kjss"]];
        
    }else if  ([self.detailModel.type isEqual:@"税务其他"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtsw"]];
        
    }else if  ([self.detailModel.type isEqual:@"年报审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"nbsj"]];
        
    }else if  ([self.detailModel.type isEqual:@"上市审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"sssj"]];
        
    }else if  ([self.detailModel.type isEqual:@"债券审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"zqsj"]];
        
    }else if  ([self.detailModel.type isEqual:@"验资审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"yzsj"]];
        
    }else if  ([self.detailModel.type isEqual:@"内容审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"nksj"]];
        
    }else if  ([self.detailModel.type isEqual:@"其他审计"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtsj"]];
        
    }else if  ([self.detailModel.type isEqual:@"会计核算"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kjhs"]];
        
    }else if  ([self.detailModel.type isEqual:@"政策咨询"]){
        [self.typeImg setImage:[UIImage imageNamed:@"zczx"]];
        
    }else if  ([self.detailModel.type isEqual:@"财务管理"]){
        [self.typeImg setImage:[UIImage imageNamed:@"cwgl"]];
        
    }else if  ([self.detailModel.type isEqual:@"报表编制"]){
        [self.typeImg setImage:[UIImage imageNamed:@"bbbz"]];
        
    }else if  ([self.detailModel.type isEqual:@"会计其他"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtkj"]];
        
    }else if  ([self.detailModel.type isEqual:@"资产评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([self.detailModel.type isEqual:@"单项评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([self.detailModel.type isEqual:@"整体评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([self.detailModel.type isEqual:@"价值评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([self.detailModel.type isEqual:@"其他评估"]){
        [self.typeImg setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([self.detailModel.type isEqual:@"财务软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"cwrj"]];
        
    }else if  ([self.detailModel.type isEqual:@"审计软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"sjrj"]];
        
    }else if  ([self.detailModel.type isEqual:@"office软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"office"]];
        
    }else if  ([self.detailModel.type isEqual:@"其他软件"]){
        [self.typeImg setImage:[UIImage imageNamed:@"qtrj"]];
        
    }
    
    if (!self.detailModel.photos) {
        NSArray *PhotoArray = [self.detailModel.photos componentsSeparatedByString:@","];
        
        
        
        NSInteger index = -1;
        NSLog(@"%zd",index);
        for (UIImageView *imageView in self.contentImgs) {
            index++;
            if (PhotoArray.count <= index) {
                imageView.hidden = YES;
                [self.contentBtn[index] setHidden: YES];
                continue;
            }
            imageView.hidden = NO;
            [self.contentBtn[index] setHidden: NO];
            [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameReward,OSS,PhotoArray[index]]]];
        }
    }
   
    
    
}
- (IBAction)imageButtonAction:(UIButton *)sender {
    
    UIImageView *imageView = self.contentImgs[sender.tag];
    
    [self.avatarDisplayView showFromImageView:imageView];
    
}

#pragma mark - Lazy load
- (MLAvatarDisplayView *)avatarDisplayView {
    if (!_avatarDisplayView) {
        _avatarDisplayView = [MLAvatarDisplayView ml_singleImageDisplayView];
    }
    return _avatarDisplayView;
}

@end
