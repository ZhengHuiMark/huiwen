//
//  ZHConsultingMeVoiceTableViewCell.m
//  will ask
//
//  Created by 郑晖 on 2018/1/23.
//  Copyright © 2018年 Hui Zheng. All rights reserved.
//

#import "ZHConsultingMeVoiceTableViewCell.h"
#import "ZHAllConsultingMeModel.h"
#import "MLAvatarDisplayView.h"
#import "ImageTools.h"

@interface ZHConsultingMeVoiceTableViewCell()

@property (nonatomic, strong) MLAvatarDisplayView *avatarDisplayView;


@end
@implementation ZHConsultingMeVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZHAllConsultingMeModel *)model{
    _model = model;
    
    [self.expertChaseAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",bucketNameUserLoad,OSS,model.expertAvatar]]];
    self.expertName.text = model.expertNickname;
    self.expertChaseCerTitle.text = model.expertCertifiedNames;
    [self.expertChaseAnswerImg setImage:[UIImage imageNamed:@"answer"]];
    self.expertChaseTime.text = model.addAnswerTime;
    
    NSArray *PhotoArray = [model.addAnswerPhotos componentsSeparatedByString:@","];
    if (model.addAnswerPhotos) {
        [PhotoArray arrayByAddingObject:model.addAnswerPhotos];
    }
    NSLog(@"123  = %@",PhotoArray);
    
    NSInteger index = -1;
    NSLog(@"%zd",index);
    for (UIImageView *imageView in self.expertChaseImgs) {
        index++;
        if (PhotoArray.count <= index) {
            imageView.hidden = YES;
            [self.expertChaseBtnImgs[index] setHidden: YES];
            continue;
        }
        imageView.hidden = NO;
        [self.expertChaseBtnImgs[index] setHidden: NO];
        [imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",bucketNameConsultLoad,OSS,PhotoArray[index]]]];
    }
    
}

- (IBAction)btnAction:(UIButton *)sender {
    
    UIImageView *imageView = self.expertChaseImgs[sender.tag];
    
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
