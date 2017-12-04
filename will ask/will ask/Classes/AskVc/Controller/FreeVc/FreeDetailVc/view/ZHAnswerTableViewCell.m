//
//  ZHAnswerTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/10/31.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHAnswerTableViewCell.h"
#import "ZHFreeAnswerModel.h"
#import "ZHFreeDetailModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"
#import "MLAvatarDisplayView.h"


@interface ZHAnswerTableViewCell ()

@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end


@implementation ZHAnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setDetailModel:(ZHFreeDetailModel *)detailModel {

    _detailModel = detailModel;

}


- (void)setAnswerModel:(ZHFreeAnswerModel *)answerModel {
    
    _answerModel = answerModel;
        
    
    self.answerName.text = self.answerModel.nickname;
    [self.answerAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUser,OSS,self.answerModel.avatar]]];
//    self.answerExpert.text = answerModel.
    self.answerContent.text = self.answerModel.content;
    
    
}


- (IBAction)imageButtonAction:(UIButton *)sender {
    UIImageView *imageView = self.answerImgs[sender.tag];
    [self.avatarDisplayView showFromImageView: imageView];
    
}


#pragma mark - Lazy load
- (MLAvatarDisplayView *)avatarDisplayView {
    if (!_avatarDisplayView) {
        _avatarDisplayView = [MLAvatarDisplayView ml_singleImageDisplayView];
    }
    return _avatarDisplayView;
}

@end
