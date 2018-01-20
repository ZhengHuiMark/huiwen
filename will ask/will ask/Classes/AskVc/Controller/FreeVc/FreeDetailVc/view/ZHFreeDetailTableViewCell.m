//
//  ZHFreeDetailTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/10/31.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHFreeDetailTableViewCell.h"
#import "ZHFreeDetailModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"
#import "Macro.h"
#import "MLAvatarDisplayView.h"
#import "ImageTools.h"

@interface ZHFreeDetailTableViewCell()

@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end

@implementation ZHFreeDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHFreeDetailModel *)model {
    
    _model = model;
    
//    self.userava
    self.userNickName.text = self.model.nickname;
    self.browseNumber.text = self.model.readNumber;
    self.releaseTime.text = self.model.time;
 
 
    
    [self.userAvatarImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.model.avatar]]];
    
    self.contentL.text = [NSString stringWithFormat:@"       %@",self.model.content];
    
    
    [self.AskImg setImage:[UIImage imageNamed:@"ask"]];
    
    
    NSArray *PhotoArray = [self.model.photos componentsSeparatedByString:@","];
    if (self.model.photos) {
        [PhotoArray arrayByAddingObject:self.model.photos];
    }
    NSLog(@"123  = %@",PhotoArray);
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.ContentImageView) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.imageButtons[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.imageButtons[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameFreeLoad,OSS,PhotoArray[index]]]];
    }
    
    
    
    if ([self.model.type  isEqual: @"涉税实务"]) {
        [self.typeImage setImage:[UIImage imageNamed:@"sssw"]];
    }else if ([self.model.type isEqual:@"税收优惠"]){
        [self.typeImage setImage:[UIImage imageNamed:@"ssyh"]];
        
    }else if  ([self.model.type isEqual:@"发票管理"]){
        [self.typeImage setImage:[UIImage imageNamed:@"fpgl"]];
        
    }else if  ([self.model.type isEqual:@"税收筹划"]){
        [self.typeImage setImage:[UIImage imageNamed:@"ssch"]];
        
    }else if  ([self.model.type isEqual:@"纳税申报"]){
        [self.typeImage setImage:[UIImage imageNamed:@"nssb"]];
        
    }else if  ([self.model.type isEqual:@"跨境税收"]){
        [self.typeImage setImage:[UIImage imageNamed:@"kjss"]];
        
    }else if  ([self.model.type isEqual:@"税务其他"]){
        [self.typeImage setImage:[UIImage imageNamed:@"qtsw"]];
        
    }else if  ([self.model.type isEqual:@"年报审计"]){
        [self.typeImage setImage:[UIImage imageNamed:@"nbsj"]];
        
    }else if  ([self.model.type isEqual:@"上市审计"]){
        [self.typeImage setImage:[UIImage imageNamed:@"sssj"]];
        
    }else if  ([self.model.type isEqual:@"债券审计"]){
        [self.typeImage setImage:[UIImage imageNamed:@"zqsj"]];
        
    }else if  ([self.model.type isEqual:@"验资审计"]){
        [self.typeImage setImage:[UIImage imageNamed:@"yzsj"]];
        
    }else if  ([self.model.type isEqual:@"内容审计"]){
        [self.typeImage setImage:[UIImage imageNamed:@"nksj"]];
        
    }else if  ([self.model.type isEqual:@"其他审计"]){
        [self.typeImage setImage:[UIImage imageNamed:@"qtsj"]];
        
    }else if  ([self.model.type isEqual:@"会计核算"]){
        [self.typeImage setImage:[UIImage imageNamed:@"kjhs"]];
        
    }else if  ([self.model.type isEqual:@"政策咨询"]){
        [self.typeImage setImage:[UIImage imageNamed:@"zczx"]];
        
    }else if  ([self.model.type isEqual:@"财务管理"]){
        [self.typeImage setImage:[UIImage imageNamed:@"cwgl"]];
        
    }else if  ([self.model.type isEqual:@"报表编制"]){
        [self.typeImage setImage:[UIImage imageNamed:@"bbbz"]];
        
    }else if  ([self.model.type isEqual:@"会计其他"]){
        [self.typeImage setImage:[UIImage imageNamed:@"qtkj"]];
        
    }else if  ([self.model.type isEqual:@"资产评估"]){
        [self.typeImage setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([self.model.type isEqual:@"单项评估"]){
        [self.typeImage setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([self.model.type isEqual:@"整体评估"]){
        [self.typeImage setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([self.model.type isEqual:@"价值评估"]){
        [self.typeImage setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([self.model.type isEqual:@"其他评估"]){
        [self.typeImage setImage:[UIImage imageNamed:@"kuaiji"]];
        
    }else if  ([self.model.type isEqual:@"财务软件"]){
        [self.typeImage setImage:[UIImage imageNamed:@"cwrj"]];
        
    }else if  ([self.model.type isEqual:@"审计软件"]){
        [self.typeImage setImage:[UIImage imageNamed:@"sjrj"]];
        
    }else if  ([self.model.type isEqual:@"office软件"]){
        [self.typeImage setImage:[UIImage imageNamed:@"office"]];
        
    }else if  ([self.model.type isEqual:@"其他软件"]){
        [self.typeImage setImage:[UIImage imageNamed:@"qtrj"]];
        
    }
    
}

- (IBAction)imageButtonAction:(UIButton *)sender {
    
    UIImageView *imageView = self.ContentImageView[sender.tag];
    
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
