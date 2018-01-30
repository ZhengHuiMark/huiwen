//
//  ZHRewardAnswerVoiceTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardAnswerVoiceTableViewCell.h"
#import "ZHFreeDetailModel.h"
#import "ZHFreeAnswerModel.h"
#import "ImageTools.h"
#import "MLAvatarDisplayView.h"
#import "UIImageView+WebCache.h"


@interface ZHRewardAnswerVoiceTableViewCell()

@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end

@implementation ZHRewardAnswerVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.setBestBtn setCornerRadius:12.5];
    self.setBestBtn.layer.borderWidth = 1.0;
    self.setBestBtn.layer.borderColor = [UIColor redColor].CGColor;
    [self.userAvatar setCornerRadius:12];

}

- (void)setDetailModel:(ZHFreeDetailModel *)detailModel {
    
    _detailModel = detailModel;
    
    if (_detailModel.owner == YES) {
        
        self.learnBtn.hidden = YES;
        self.backGroundImg.hidden = YES;
        
        if (self.answerModel.best == YES) {
            self.bestImage.hidden = NO;
            self.setBestBtn.hidden = YES;
        }
        
    }
    
}


- (void)setAnswerModel:(ZHFreeAnswerModel *)answerModel {
    _answerModel = answerModel;

    if (self.answerModel.owner == YES || _detailModel.owner == YES) {
        self.learnBtn.hidden = YES;
        self.backGroundImg.hidden = YES;
    }else{
        self.learnBtn.hidden = NO;
        self.backGroundImg.hidden = NO;
    }
    
    if (self.answerModel.learned == YES || self.answerModel.owner == YES || _detailModel.owner == YES) {
        self.learnBtn.hidden = YES;
        self.backGroundImg.hidden = YES;
    }else{
        self.learnBtn.hidden = NO;
        self.backGroundImg.hidden = NO;
    }
    
    if (self.answerModel.best == YES) {
        self.bestImage.hidden = NO;
    }else{
        self.bestImage.hidden = YES;
    }
    
    
    if (self.answerModel.best == YES && _detailModel.owner == YES ) {
        self.bestImage.hidden = NO;
        self.setBestBtn.hidden = YES;
    }else if(self.answerModel.best == YES && _detailModel.owner == NO){
        self.bestImage.hidden = NO;
        self.setBestBtn.hidden = YES;
    }else if (self.answerModel.best == NO && _detailModel.owner == YES){
        self.bestImage.hidden = YES;
        self.setBestBtn.hidden = NO;
    }else if (self.answerModel.best == NO && _detailModel.owner == NO){
        self.bestImage.hidden = YES;
        self.setBestBtn.hidden = YES;
    }
    
    self.userName.text = self.answerModel.nickname;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.answerModel.avatar]]];
    self.expertName.text = self.answerModel.certifiedNames;
    if (self.answerModel.honor) {
        self.expertHoor.text = self.answerModel.honor;
    }else{
        self.expertHoor.backgroundColor = [UIColor whiteColor];
    }
    
    self.labelNumber = [self.answerModel.praiseNumber integerValue];
    self.ClickUpNumber.text = self.answerModel.praiseNumber;
    
    self.learnNumber.text = [NSString stringWithFormat:@"%@人已学习",self.answerModel.learnNumber];
    
    self.releaseTime.text = self.answerModel.time;
    
    NSArray *PhotoArray = [self.answerModel.photos componentsSeparatedByString:@","];
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.ansImgViews) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.ansImgBtn[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.ansImgBtn[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameRewardLoad,OSS,PhotoArray[index]]]];
    }
}

- (IBAction)imgBtnAction:(UIButton *)sender {
    
    
    UIImageView *imageView = self.ansImgViews[sender.tag];
    
    [self.avatarDisplayView showFromImageView:imageView];
}


#pragma mark - Lazy load
- (MLAvatarDisplayView *)avatarDisplayView {
    if (!_avatarDisplayView) {
        _avatarDisplayView = [MLAvatarDisplayView ml_singleImageDisplayView];
    }
    return _avatarDisplayView;
}

- (IBAction)learnPayAction:(UIButton *)sender {
    
    !self.didClick?:self.didClick();
    
}

- (IBAction)bestAction:(UIButton *)sender {
    
    
}


- (IBAction)clickPriseAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        [dic setObject:self.answerModel.answerId forKey:@"objectId"];
        [dic setObject:@"2" forKey:@"type"];
        
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/praise/add",kIP];
        
        [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
            
            if (error) {
                NSLog(@"%@",error);
            }
            
            NSLog(@"%@",response);
            if ([response[@"success"] integerValue] == 1) {
                _labelNumber++;
                self.ClickUpNumber.text = [NSString stringWithFormat:@"%ld",_labelNumber];
            }
            
        }];
        
    }else{
        NSMutableDictionary *dic = [ZHNetworkTools parameters];
        [dic setObject:self.answerModel.answerId forKey:@"objectId"];
        [dic setObject:@"2" forKey:@"type"];
        
        NSString *url = [NSString stringWithFormat:@"%@/api/ut/praise/cancel",kIP];
        
        [[ZHNetworkTools sharedTools]requestWithType:POST andUrl:url andParams:dic andCallBlock:^(id response, NSError *error) {
            
            if (error) {
                NSLog(@"%@",error);
            }
            
            NSLog(@"%@",response);
            if ([response[@"success"] integerValue] == 1) {
                _labelNumber--;
                self.ClickUpNumber.text = [NSString stringWithFormat:@"%ld",_labelNumber];
            }
            
        }];
    }
}



@end
