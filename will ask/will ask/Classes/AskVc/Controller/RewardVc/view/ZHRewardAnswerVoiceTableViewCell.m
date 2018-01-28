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
}

- (void)setDetailModel:(ZHFreeDetailModel *)detailModel {
    
    _detailModel = detailModel;
}


- (void)setAnswerModel:(ZHFreeAnswerModel *)answerModel {
    _answerModel = answerModel;
    
    if (self.answerModel.owner == YES) {
        self.learnBtn.hidden = YES;
        self.backGroundImg.hidden = YES;
    }else{
        self.learnBtn.hidden = NO;
        self.backGroundImg.hidden = NO;
    }
    
    if (self.answerModel.learned == YES || self.answerModel.owner == YES) {
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
    
    self.userName.text = self.answerModel.nickname;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.answerModel.avatar]]];
    self.expertName.text = self.answerModel.certifiedNames;
    self.expertHoor.text = self.answerModel.honor;
    self.ClickUpNumber.text = self.answerModel.praiseNumber;
    
    
    self.learnNumber.text = self.answerModel.learnNumber;
    
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


@end
