//
//  ZHAnswerVoiceTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/10/31.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHAnswerVoiceTableViewCell.h"
#import "ZHFreeDetailModel.h"
#import "ZHFreeAnswerModel.h"
#import "ImageTools.h"
#import "UIImageView+WebCache.h"
#import "MLAvatarDisplayView.h"

@interface ZHAnswerVoiceTableViewCell ()

@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end

@implementation ZHAnswerVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDetailModel:(ZHFreeDetailModel *)detailModel {
    _detailModel = detailModel;
}


- (void)setAnswerVoiceModel:(ZHFreeAnswerModel *)answerVoiceModel {
    _answerVoiceModel = answerVoiceModel;
    
    
    self.answerName.text = answerVoiceModel.nickname;
    [self.userAvatarImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,answerVoiceModel.avatar]]];
    //    self.answerExpert.text = answerModel.
    
    NSArray *PhotoArray = [self.answerVoiceModel.photos componentsSeparatedByString:@","];
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.answerImage) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.answerImgBtn[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.answerImgBtn[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameRewardLoad,OSS,PhotoArray[index]]]];
    }
    
}


- (IBAction)imgBtnAction:(UIButton *)sender {
    
    UIImageView *imageView = self.answerImage[sender.tag];
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
