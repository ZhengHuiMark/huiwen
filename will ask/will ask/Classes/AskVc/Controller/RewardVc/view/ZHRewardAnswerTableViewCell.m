//
//  ZHRewardAnswerTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2017/11/2.
//  Copyright © 2017年 Hui Zheng. All rights reserved.
//

#import "ZHRewardAnswerTableViewCell.h"
#import "ZHFreeAnswerModel.h"
#import "ZHFreeDetailModel.h"
#import "ImageTools.h"
#import "Macro.h"
#import "MLAvatarDisplayView.h"
#import "UIImageView+WebCache.h"

@interface ZHRewardAnswerTableViewCell ()


@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end

@implementation ZHRewardAnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetailModel:(ZHFreeDetailModel *)detailModel {
    
    _detailModel = detailModel;
}


- (void)setAnswerModel:(ZHFreeAnswerModel *)answerModel {
    _answerModel = answerModel;
    
    
    self.content.text = self.answerModel.content;
    
    self.expertName.text = self.answerModel.certifiedNames;
    
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.answerModel.avatar]]];
    
    self.userName.text = self.answerModel.nickname;
    
    //    self.expertName.text = self.answerModel.
    
    self.clickNumber.text = self.answerModel.praiseNumber;
    
    
    self.learnNumber.text = self.answerModel.learnNumber;
    
    self.releaseTime.text = self.answerModel.time;
    
    NSArray *PhotoArray = [self.answerModel.photos componentsSeparatedByString:@","];
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.answerImgs) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.ansImgButtons[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.ansImgButtons[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameRewardLoad,OSS,PhotoArray[index]]]];
    }
    

}

- (IBAction)imgsBtnAction:(UIButton *)sender {
    
    
    UIImageView *imageView = self.answerImgs[sender.tag];
    
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
