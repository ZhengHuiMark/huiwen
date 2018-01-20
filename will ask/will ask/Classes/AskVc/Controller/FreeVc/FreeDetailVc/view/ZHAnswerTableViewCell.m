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
    [self.answerAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,self.answerModel.avatar]]];
    self.answerExpert.text = answerModel.certifiedNames;
    self.answerContent.text = self.answerModel.content;
    self.answerTime.text = self.answerModel.time;
    
    NSArray *PhotoArray = [self.answerModel.photos componentsSeparatedByString:@","];
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.answerImgs) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.answerimgBtns[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.answerimgBtns[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameFreeLoad,OSS,PhotoArray[index]]]];
    }
    
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
